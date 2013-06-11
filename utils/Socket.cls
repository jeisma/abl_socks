
class utils.Socket:

   def protected var callback_handle as handle no-undo.
   
<<<<<<< HEAD
   def protected property connection_handle as handle get. set.

   def public property err_msg as char public get. protected set.
=======
   def public property connection_handle as handle  public get. protected set.
>>>>>>> 1fca63e0c561510496664c0e24ef9c2d299eff6e


   constructor public Socket():
      run utils/SocketCallback.p persistent set callback_handle (this-object).    
   end constructor.

               
<<<<<<< HEAD
   method protected log write_msg (msg as char):                 
      return yes.
   end method.
   
   
   method protected char read_msg() :              
      return 'msg'.            
   end method.

      
   method protected log valid_handle (socket_handle as handle):
      if not valid-handle(socket_handle) then do:
         err_msg = "Invalid socket handle".
         return no.
      end.

      err_msg = "".
      return yes.
   end method.


=======
   method public log write_msg (msg as char):           
    
      def var mpData as memptr  no-undo.
      def var iSize  as integer no-undo.
      def var isOK   as logical no-undo.
   
      def var iBytesToWrite as integer no-undo.
      def var iBytesOffset  as integer  no-undo init 1.
      def var iBytesWritten as integer no-undo.
   
      if not valid-handle(connection_handle) or 
        not connection_handle:connected() then return no.
   
      assign 
        set-size(mpData)             = 0
        set-byte-order(mpData)       = big-endian
        iSize                           = length (msg, "RAW":U )
        set-size (mpData)             = iSize
        put-string (mpData, 1, iSize) = msg.
   
      assign iBytesToWrite = get-size(mpData).
      
      do while iBytesToWrite > 0 :
         isOK = connection_handle:write (mpData, iBytesOffset, iBytesToWrite ).
         assign
           iBytesWritten = connection_handle:bytes-written 
           iBytesOffset  = iBytesOffset + iBytesWritten
           iBytesToWrite = iBytesToWrite - iBytesWritten.
         if connection_handle:connected( ) = no then do: 
            assign isOK = no
                   iBytesToWrite = 0 .
         end.
      end.
   
      set-size (mpData)  = 0.
   
      return isOK.
   end method.
   
   
   method public char read_msg() :              
      def var iBytesAvailable as integer     no-undo.
      def var mpData      as memptr  no-undo.
      def var msg as char no-undo.
   
      if not valid-handle ( connection_handle ) or 
         not connection_handle:connected( ) then return "NO":U.
   
      iBytesAvailable = connection_handle:get-bytes-available().
      if iBytesAvailable > 0 then do:
         set-size(mpData) = iBytesAvailable + 1.
         connection_handle:read(mpData, 1, iBytesAvailable, 1).
         msg = get-string(mpData,1).
         set-size(mpData) = 0.
      end.
      
      if iBytesAvailable = 0 then do:
         message 'Unable To Read Header Bytes'.
         return "NO":U.
      end.
   
      return msg.
      
      finally:
         set-size(mpData) = 0.
      end finally.       
   end method.


   method public log set_response_proc (socket_handle as handle):
      def var method_ok as logical no-undo.
      
      /*socket_handle is valid? */
      
      method_ok = socket_handle:set-read-response-procedure('process_response', callback_handle) no-error.
      if method_ok = false or error-status:get-message(1) <> '' then do:
         message "** Unable To Establish Read Response Procedure"
            view-as alert-box info buttons ok.
         return false .
      end.
   end method.      
      
      
>>>>>>> 1fca63e0c561510496664c0e24ef9c2d299eff6e
   destructor public Socket ():
      if valid-handle(callback_handle) then 
         delete procedure callback_handle.         
   end destructor.      
end class.
