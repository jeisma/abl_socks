
class utils.SocketServer inherits utils.Socket :
   def private var server_handle   as handle no-undo.      
   
<<<<<<< HEAD
   define variable lRC as logical no-undo.
   define variable mHeader as memptr no-undo.
   define variable mData as memptr no-undo.
   define variable iDataSize as integer no-undo.

   constructor public SocketServer (port_no as char):
      def var method_ok as logical no-undo.
     
      create server-socket server_handle.      
      server_handle:set-connect-procedure('client_connect_procedure', callback_handle).
                  
      method_ok = server_handle:enable-connections('-S ' + port_no) no-error.
      if method_ok = false or error-status:get-message(1) <> '' then do:
         err_msg = 'Unable To Establish Listener'.
         return.
      end.      
      
      /*--------------------------------------------------------*/
      /* Allocate 4 byte header block once (for performance) */
      /* and specify the order of the bytes within the pointer */
      /* which is needed to guarantee proper interpretation of */
      /* the data between machines whose CPU's have different */
      /* byte orders */
      /*--------------------------------------------------------*/
      SET-SIZE(mHeader) = 4.
      SET-BYTE-ORDER(mHeader) = big-endian.                 
   end constructor.                                                                                     

                     
   method public log client_connect_procedure (client_socket as handle):
      def var method_ok as logical no-undo.

      if not valid_handle(client_socket) then
         return no.

      client_socket:set-read-response-procedure('process_io', callback_handle).      
   end method.
   
   
   method public void process_io ():

      connection_handle = self.
      if not connection_handle:connected() then do:  
         err_msg = "not connected to server".
         return. 
      end.
            
      define variable cTime as character no-undo.
      define variable iMessageSize as integer no-undo.
      /*----------------------------------------------------*/
      /* Check to see if the socket is still connected, if */
      /* not, then exit from this internal procedure */
      /* */
      /* Please note that this check is done because it is */
      /* possible for a client to have become disconnecte.d */
      /* by the time we receive this message. and if that is */
      /* the case we don't want to do anything with this */
      /* message */
      /*----------------------------------------------------*/
      if connection_handle:CONNECTED() = false then
      return.
      /*----------------------------------------------------*/
      /* The following code reads the header block we are */
      /* using on each packet of data being sent. We are */
      /* prefixing each packet with a 4 byte integer that */
      /* tells us how much "real" data to expect. This is */
      /* done because we cannot be guaranteed that all of */
      /* the data that was sent actually reached Progress */
      /* at the same time. Since we are invoking a */
      /* blocking read method, we want to be sure that we */
      /* know how much data to read so that we don't sit */
      /* around in the blocking read method forever waiting */
      /* for data that will never arrive */
      /*----------------------------------------------------*/
      /*----------------------------------------------------*/
      /* Read 4 byte header block */
      /*----------------------------------------------------*/
      lRC = connection_handle:READ(mHeader,1,4,2) no-error.
      if lRC = false or error-status:get-message(1) <> '' then
      do:
         display 'Unable To Read Header Bytes'.
         return.
      end.
      /*----------------------------------------------------*/
      /* Now that the header block has been successfully */
      /* read, we know how much real data to read, so we go */
      /* do the read */
      /*----------------------------------------------------*/
      iMessageSize = get-long(mHeader,1).
      if iDataSize < iMessageSize then
      do:
         SET-SIZE(mData) = 0.
         SET-SIZE(mData) = iMessageSize.
         iDataSize = iMessageSize.
         SET-BYTE-ORDER(mData) = big-endian.
      end.
      
      lRC = connection_handle:READ(mData,1,iMessageSize,2) no-error.
      if lRC = false or error-status:get-message(1) <> '' then
      do:
         display 'Unable To Read Detail Bytes'.
         return.
      end.
      /*----------------------------------------------------*/
      /* At this point, data has been successfully read */
      /* from the client (it doesn't matter what data was */
      /* read) */
      /*----------------------------------------------------*/
      /*----------------------------------------------------*/
      /* Now we reuse the mData memory pointer and send a */
      /* new message back to the client that consists of */
      /* the current time in HH:MM:SS format */
      /*----------------------------------------------------*/
      assign cTime = string(time,'HH:MM:SS').
      /*----------------------------------------------------*/
      /* Make sure that the mData memory pointer is sized */
      /* large enough for our purposes */
      /*----------------------------------------------------*/
      if iDataSize < 13 then
      do:
         SET-SIZE(mData) = 0.
         SET-SIZE(mData) = 13.
         iDataSize = 13.
         SET-BYTE-ORDER(mData) = big-endian.
      end.
      /*----------------------------------------------------*/
      /* Fill the memory pointer with data (header + the */
      /* real data) and write the data to the socket */
      /*----------------------------------------------------*/
      PUT-LONG(mData,1) = length(cTime) + 1.
      PUT-STRING(mData,5) = cTime.
      lRC = connection_handle:WRITE(mData,1,13) no-error.
      if lRC = false or error-status:get-message(1) <> '' then
      do:
         display 'Unable To Write Detail Bytes'.
         return.
      end.            
   end method.
   
   
   method public void listen ():
      repeat on stop undo, leave on quit undo, leave:
         wait-for connect of server_handle.
      end.      
   end method.       
=======
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
   
>>>>>>> 1fca63e0c561510496664c0e24ef9c2d299eff6e
   
   destructor SocketServer ():
      if valid-handle(server_handle) then do:
         server_handle:disable-connections().
         delete object server_handle.
<<<<<<< HEAD
         SET-SIZE(mHeader) = 0.
         SET-SIZE(mData) = 0.
      end.     
=======
      end.
      
      if valid-handle(callback_handle) then
         delete procedure callback_handle.
>>>>>>> 1fca63e0c561510496664c0e24ef9c2d299eff6e
   end destructor.
end class.
