


create proc [gokul]

as begin 

select getdate()
--Test Connection: FAILED
--JBR error: java.sql.SQLException: Data Lake is not available
--	at com.infor.idl.jdbc.Driver.connect(Driver.java:421)
--	at DbConnection.Init(DbConnection.java:45)
--	at ClientHandler.openConnection(ClientHandler.java:245)
--	at ClientHandler.dispatch(ClientHandler.java:122)
--	at ClientHandler.lambda$0(ClientHandler.java:72)
--	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)
--	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)
--	at java.lang.Thread.run(Thread.java:750)
--Caused by: java.util.concurrent.CompletionException: com.infor.idl.shaded.javax.ws.rs.ProcessingException: java.net.ConnectException: Connection timed out: connect
--	at java.util.concurrent.CompletableFuture.encodeThrowable(CompletableFuture.java:273)
--	at java.util.concurrent.CompletableFuture.completeThrowable(CompletableFuture.java:280)
--	at java.util.concurrent.CompletableFuture$AsyncSupply.run(CompletableFuture.java:1606)
--	... 3 more
--Caused by: com.infor.idl.shaded.javax.ws.rs.ProcessingException: java.net.ConnectException: Connection timed out: connect
--	at com.infor.idl.shaded.org.glassfish.jersey.client.internal.HttpUrlConnector.apply(HttpUrlConnector.java:260)
--	at com.infor.idl.shaded.org.glassfish.jersey.client.ClientRuntime.invoke(ClientRuntime.java:254)
--	at com.infor.idl.shaded.org.glassfish.jersey.client.JerseyInvocation.lambda$invoke$0(JerseyInvocation.java:736)
--	at com.infor.idl.shaded.org.glassfish.jersey.internal.Errors.process(Errors.java:292)
--	at com.infor.idl.shaded.org.glassfish.jersey.internal.Errors.process(Errors.java:274)
--	at com.infor.idl.shaded.org.glassfish.jersey.internal.Errors.process(Errors.java:205)
--	at com.infor.idl.shaded.org.glassfish.jersey.process.internal.RequestScope.runInScope(RequestScope.java:390)
--	at com.infor.idl.shaded.org.glassfish.jersey.client.JerseyInvocation.invoke(JerseyInvocation.java:735)
--	at com.infor.idl.shaded.org.glassfish.jersey.client.JerseyInvocation$Builder.method(JerseyInvocation.java:395)
--	at com.infor.dmp.common.oauth.client.NoAuthenticationClient.makeRequestAndWaitForResponse(NoAuthenticationClient.java:126)
--	at com.infor.dmp.common.oauth.client.RetryingOAuthClient.makeRequestAndWaitForResponse(RetryingOAuthClient.java:99)
--	at com.infor.dmp.common.query.client.TokenAuthenticatingClient.makeRequestAndWaitForResponse(TokenAuthenticatingClient.java:144)
--	at com.infor.dmp.common.query.client.TokenAuthenticationStatementClient.pingInternal(TokenAuthenticationStatementClient.java:135)
--	at com.infor.dmp.common.query.client.TokenAuthenticationStatementClient.lambda$ping$1(TokenAuthenticationStatementClient.java:127)
--	at java.util.concurrent.CompletableFuture$AsyncSupply.run(CompletableFuture.java:1604)
--	... 3 more
--Caused by: java.net.ConnectException: Connection timed out: connect
--	at java.net.DualStackPlainSocketImpl.connect0(Native Method)
--	at java.net.DualStackPlainSocketImpl.socketConnect(DualStackPlainSocketImpl.java:79)
--	at java.net.AbstractPlainSocketImpl.doConnect(AbstractPlainSocketImpl.java:350)
--	at java.net.AbstractPlainSocketImpl.connectToAddress(AbstractPlainSocketImpl.java:206)
--	at java.net.AbstractPlainSocketImpl.connect(AbstractPlainSocketImpl.java:188)
--	at java.net.PlainSocketImpl.connect(PlainSocketImpl.java:172)
--	at java.net.SocksSocketImpl.connect(SocksSocketImpl.java:392)
--	at java.net.Socket.connect(Socket.java:607)
--	at sun.security.ssl.SSLSocketImpl.connect(SSLSocketImpl.java:293)
--	at sun.net.NetworkClient.doConnect(NetworkClient.java:175)
--	at sun.net.www.http.HttpClient.openServer(HttpClient.java:463)
--	at sun.net.www.http.HttpClient.openServer(HttpClient.java:558)
--	at sun.net.www.protocol.https.HttpsClient.<init>(HttpsClient.java:264)
--	at sun.net.www.protocol.https.HttpsClient.New(HttpsClient.java:367)
--	at sun.net.www.protocol.https.AbstractDelegateHttpsURLConnection.getNewHttpClient(AbstractDelegateHttpsURLConnection.java:203)
--	at sun.net.www.protocol.http.HttpURLConnection.plainConnect0(HttpURLConnection.java:1162)
--	at sun.net.www.protocol.http.HttpURLConnection.plainConnect(HttpURLConnection.java:1056)
--	at sun.net.www.protocol.https.AbstractDelegateHttpsURLConnection.connect(AbstractDelegateHttpsURLConnection.java:189)
--	at sun.net.www.protocol.http.HttpURLConnection.getInputStream0(HttpURLConnection.java:1572)
--	at sun.net.www.protocol.http.HttpURLConnection.getInputStream(HttpURLConnection.java:1500)
--	at java.net.HttpURLConnection.getResponseCode(HttpURLConnection.java:480)
--	at sun.net.www.protocol.https.HttpsURLConnectionImpl.getResponseCode(HttpsURLConnectionImpl.java:352)
--	at com.infor.idl.shaded.org.glassfish.jersey.client.internal.HttpUrlConnector._apply(HttpUrlConnector.java:366)
--	at com.infor.idl.shaded.org.glassfish.jersey.client.internal.HttpUrlConnector.apply(HttpUrlConnector.java:258)
--	... 17 more



end

GO

