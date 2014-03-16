jQuery ->
  @app = window.app ? {}

  Xmpp = (jid, passwd, host) ->
    @jid = jid
    @passwd = passwd
    @host = host
    @conn = null
    @app = window.app ? {}
    @ns = "http://www.xmpp.org/extensions/xep-0136.html#ns"
    @notifi_col = new Array()
    @connect()

  Xmpp::log = (msg) ->
    console.log(msg);
    @

  Xmpp::connect = () ->
    @log("connect function")
    @conn = new Strophe.Connection("http://"+@host+"/http-bind");
    @conn.connect(@jid+"@courseshub", @passwd, @onConnect.bind(@))
    @

  Xmpp::onConnect = (status) ->
    @log("onConnect function")
    if status == Strophe.Status.CONNECTING
      @log('Strophe is connecting.');
    else if status == Strophe.Status.CONNFAIL
      @log('Strophe failed to connect.');
      @log('Strophe is trying to connect again.');
      @connect()
    else if status == Strophe.Status.DISCONNECTING
      @log('Strophe is disconnecting.');
    else if status == Strophe.Status.DISCONNECTED
      @log('Strophe is disconnected.');
    else if status == Strophe.Status.CONNECTED
      @log('Strophe is connected.');
      @onConnected()
    @

  Xmpp::onConnected = () ->
    @log("onConnected function")

    # Handler Syntax
    # addHandler(function_name, ns, name, type, id, from)
    @conn.addHandler(@handle_pong.bind(@), null, 'iq', null, 'ping1')
    @conn.addHandler(@handle_notification_list.bind(@), null, 'iq', null, 'list')
    @conn.addHandler(@handle_ret_notifi.bind(@), null, 'iq', null, 'ret_not')
    @conn.addHandler(@handle_iq.bind(@), null, 'iq')
    @conn.addHandler(@handle_message.bind(@), null, 'message')

    $(window).bind("beforeunload", @unload_handler.bind(@))
    
    # Send presence info
    @conn.send($pres().tree())
    
    # Enable carbon copy
    @conn.send($iq({xmlns:'jabber:client', from:@conn.jid, id:'enable1', type: "set"}).c("enable", {xmlns: "urn:xmpp:carbons:2"}))
    @conn.send($iq({type: "get", id:"pref"}).c("pref", {xmlns: @ns}))
    @conn.send($iq({type: "get", id:"list"}).c("list", {xmlns: @ns, with: "courseshub"})).c({"set", xmlns: "http://jabber.org/protocol/rsm"})

    # @sendMessage("vignesh@courseshub", "Hi. How are you?")
    # @send_ping()

  Xmpp::unload_handler = () ->
    console.log("disconnecting xmpp connection")
    @conn.disconnect()

  Xmpp::handle_notification_list = (iq) ->
    @log("Got notification list")
    @log(iq)
    chat = iq.getElementsByTagName("chat")

    for msg in chat
      @log(msg)
      @notifi_col.push(msg.getAttribute("start"))

    @log(@notifi_col)
    @log("calling retrieve")
    @retrieve_notification()
    return true

  Xmpp::retrieve_notification = () ->
    if not @notifi_col.empty?
      @log("retrieving notification")
      len = @notifi_col.length
      start = @notifi_col[len-1]
      @notifi_col.splice(len-1,1)
      @conn.send($iq({type: "get", id:"ret_not"}).c("retrieve", {xmlns: @ns, with: "courseshub@courseshub/courseshub", start: start})).c({"set", xmlns: "http://jabber.org/protocol/rsm"}).c({"max"}).t("100")

  Xmpp::handle_ret_notifi = (iq) ->
    @log("return notifi handler")
    @log(iq)
    msgs = iq.getElementsByTagName("body");
    for msg in msgs
      resp = JSON.parse(msg.innerHTML)
      if not @app.notification.notifications.where({message_id: resp.message_id}).length
        @app.notification.notifications.add(new @app.NotificationModel({message_id: resp.message_id, msg: resp.msg, link: resp.link}), {at: 0})
      @app.notification.render()
    return true

  Xmpp::send_ping = () ->
    @domain = Strophe.getDomainFromJid(@conn.jid)
    @log("sending ping to "+@domain)
    ping = $iq({ to: @domain, type: "get", id: "ping1"}).c("ping", {xmplns: "urn:xmpp:ping"})
    @start_time_ping = (new Date()).getTime()
    @conn.send(ping)

  Xmpp::handle_pong = (iq) ->
    elapsed = (new Date()).getTime() - @.start_time_ping
    @log(iq)
    @log("Received pong after "+  elapsed + " ms")
    return false

  Xmpp::handle_message = (msg) ->
    from = msg.getAttribute('from');
    if from == "courseshub@courseshub/courseshub"
      @handle_notification(msg)
    else 
      @log("Got msg")
      @log(msg)
      # User chat
    return true

  Xmpp::handle_iq = (iq) ->
    @log("Got iq")
    @log(iq)
    return true

  Xmpp::handle_notification = (msg) ->
    elems = msg.getElementsByTagName('body');
    from = msg.getAttribute('from');

    body = elems[0];
    # @log(msg)
    @log('Got a notification from ' + from + ': ' + Strophe.getText(body));
    resp = JSON.parse($("<div/>").html(Strophe.getText(body)).text())
    # @log(resp)

    # push notification to backbone view and render
    if not @app.notification.notifications.where({message_id: resp.message_id}).length
      @app.notification.notifications.add(new @app.NotificationModel({message_id: resp.message_id, msg: resp.msg, link: resp.link}), {at: 0})
    @app.notification.render()
    # we must return true to keep the handler alive.  
    # returning false would remove it after it finishes.
    return true;

  Xmpp::sendMessage = (to, msg) ->
    @log("Sending msg to: "+to+" msg: "+msg)
    @conn.send($msg({to: to, type:"chat"}).c('body').t(msg))
    @

  Xmpp::getArchieves = (from, start, end, max) ->
    @

  @app.Xmpp = Xmpp