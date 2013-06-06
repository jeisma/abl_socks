
class utils.SocketServer inherits utils.Socket :
   def private var server_handle   as handle no-undo.      
   
   constructor public SocketServer (port_no as char):
      def var method_ok as logical no-undo.
     
      create server-socket server_handle.
      method_ok = server_handle:enable-connections('-S ' + port_no) no-error.
      if method_ok = false or error-status:get-message(1) <> '' then do:
         message 'Unable To Establish Connect Procedure' view-as
            alert-box.
         return.
      end.
            
      method_ok = server_handle:set-connect-procedure('process_client_connect', callback_handle).
      if method_ok = false or error-status:get-message(1) <> '' then do:
         message 'Unable To Establish Listener' 
         view-as alert-box.
         return.
      end.
   end constructor.


/*   method public void process_client_connect (client_connection_handle as handle):*/
/*      def var method_ok as logical no-undo.                                       */
/*                                                                                  */
/*      method_ok = set_response_proc(client_connection_handle).                    */
/*   end method.                                                                    */
      

   method public void process_response ():

      define variable cRequestList as character   no-undo.
      define variable iRequest as integer     no-undo.
      define variable cRequest as character   no-undo.
   
      connection_handle = self.
      if not connection_handle:connected() then do:  
         message 'server - not connected'
         view-as alert-box.
         return. 
      end.
      else message 'server - connected'
           view-as alert-box.                     
      
/*      cRequestList = super:read_msg().*/
      
/*      if entry(1, cRequestList) = "ERROR" then*/
/*         return.                              */
                
/*      client_handle = self.                              */
/*message 'cRequestList-> ' cRequestList                   */
/*view-as alert-box.                                       */
/*      do iRequest = 1 to num-entries(cRequestList,"|":U):*/
/*         cRequest = entry(iRequest,cRequestList,"|":U).  */
/*         if cRequest begins "RPC-":U then do:            */
/*/*            gcProcContext = cRequest.*/                */
/*            run value (entry(2,cRequest,"-":U)) no-error.*/
/*         end.                                            */
/*      end.                                               */
   
   end method.
   
   
   destructor SocketServer ():
      if valid-handle(server_handle) then do:
         server_handle:disable-connections().
         delete object server_handle.
      end.
      
      if valid-handle(callback_handle) then
         delete procedure callback_handle.
   end destructor.
end class.
