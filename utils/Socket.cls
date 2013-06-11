
class utils.Socket:

   def protected var callback_handle as handle no-undo.
   
   def protected property connection_handle as handle get. set.

   def public property err_msg as char public get. protected set.


   constructor public Socket():
      run utils/SocketCallback.p persistent set callback_handle (this-object).    
   end constructor.

               
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


   destructor public Socket ():
      if valid-handle(callback_handle) then 
         delete procedure callback_handle.         
   end destructor.      
end class.
