
class utils.SocketClient inherits utils.Socket :
   
   constructor public SocketClient (host as char, port_no as char):
      def var dtTimeOut as datetime no-undo.
      
      create socket connection_handle no-error.
      if not valid-handle(connection_handle) then do: 
         message "error create socket"
         view-as alert-box.
         return.
      end.
      
      dtTimeOut = now + 99.
      CONNECT_BL:
      do while dtTimeOut > now:
        connection_handle:connect("-H " + host + " -S " + port_no) no-error.

        if connection_handle:connected() then leave CONNECT_BL.
        System.Threading.Thread:Sleep(100).
      end.

message self skip connection_handle
view-as alert-box.
      set_response_proc(connection_handle).            
   end constructor.
      

   method public void process_response ():
      def var server_response as char no-undo.
         
      server_response = read_msg().
   message server_response
   view-as alert-box.
   end method.
   
   
   method public void wait_for_response():
      message valid-handle(connection_handle) skip connection_handle:connected()
      view-as alert-box.
      if valid-handle(connection_handle) then
         wait-for read-response of connection_handle.
   end method.         
      
   destructor SocketClient ():
      
   end destructor.
end class.
