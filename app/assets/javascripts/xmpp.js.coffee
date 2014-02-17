jQuery ->
  @app = window.app ? {}

  Xmpp = (jid, passwd, host) ->
    @jid = jid
    @passwd = passwd
    @host = host
    @conn = null
    @app = window.app ? {}
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
    @conn.addHandler(@handle_iq.bind(@), null, 'iq')
    @conn.addHandler(@handle_message.bind(@), null, 'message')

    $(window).bind("beforeunload", @unload_handler.bind(@))
    
    # Send presence info
    @conn.send($pres().tree())
    
    # Enable carbon copy
    @conn.send($iq({xmlns:'jabber:client', from:@conn.jid, id:'enable1', type: "set"}).c("enable", {xmlns: "urn:xmpp:carbons:2"}))
    # @conn.send($iq({type: "get", id:"version2", to: @domain}).c("query", {xmlns: "http://jabber.org/protocol/disco#info"}))

    # @sendMessage("vignesh@courseshub", "Hi. How are you?")
    # @send_ping()

  Xmpp::unload_handler = () ->
    console.log("disconnecting xmpp connection")
    @conn.disconnect()

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
    @app.notification.notifications.add(new @app.NotificationModel({message_id: resp.message_id, msg: resp.msg, link: resp.link}))
    @app.notification.render()
    # we must return true to keep the handler alive.  
    # returning false would remove it after it finishes.
    return true;

  Xmpp::sendMessage = (to, msg) ->
    @log("Sending msg to: "+to+" msg: "+msg)
    @conn.send($msg({to: to, type:"chat"}).c('body').t(msg))
    @

  @app.Xmpp = Xmpp