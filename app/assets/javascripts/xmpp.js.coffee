jQuery ->
  @app = window.app ? {}

  Xmpp = (jid, passwd, host) ->
    @jid = jid
    @passwd = passwd
    @host = host
    @conn = null
    @connect()

  Xmpp::log = (msg) ->
    console.log(msg);
    @

  Xmpp::connect = () ->
    @log("connect function")
    @conn = new Strophe.Connection("http://"+@host+"/http-bind");
    @conn.connect(@jid+"@"+@host, @passwd, @onConnect.bind(@))
    @

  Xmpp::onConnect = (status) ->
    @log("onConnect function")
    if status == Strophe.Status.CONNECTING
      @log('Strophe is connecting.');
    else if status == Strophe.Status.CONNFAIL
      @log('Strophe failed to connect.');
      @connect()
      @log('Strophe trying to connect again.');
    else if status == Strophe.Status.DISCONNECTING
      @log('Strophe is disconnecting.');
    else if status == Strophe.Status.DISCONNECTED
      @log('Strophe is disconnected.');
    else if status == Strophe.Status.CONNECTED
      @log('Strophe is connected.');
      @conn.send($pres().tree())
    @

  Xmpp::onMessage = (msg) ->
    to = msg.getAttribute('to');
    from = msg.getAttribute('from');
    type = msg.getAttribute('type');
    elems = msg.getElementsByTagName('body');

    if (type == "notification" && elems.length > 0)
      body = elems[0];
      @log('Got a message from ' + from + ': ' + Strophe.getText(body));
      # push notification to backbone view and render
    else if (type == "chat" && elems.length > 0)
      body = elems[0];
      @log('Got a message from ' + from + ': ' + Strophe.getText(body));
      # push chat to backbone view and render

    # we must return true to keep the handler alive.  
    # returning false would remove it after it finishes.
    return true;

  Xmpp::sendMessage = (msg) ->
    @

  @app.Xmpp = Xmpp