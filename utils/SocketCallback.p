def input param socket as utils.Socket.

<<<<<<< HEAD
procedure client_connect_procedure:
   def input param client_socket_handle  as handle no-undo.

   dynamic-invoke(socket, "client_connect_procedure", client_socket_handle).
end procedure.

/* handles server/client response to read/write requests */
procedure process_io:
   dynamic-invoke(socket, "process_io").
end procedure.
=======
/* procedure called when a client connects to the server socket */
procedure process_client_connect:
   def input param client_socket_handle  as handle no-undo.

   socket:set_response_proc(client_socket_handle).   
end procedure.

/* used by the client to respond to read/write requests */
procedure process_response:     
   message 123
   view-as alert-box.
   dynamic-invoke(socket, "process_response").   
end procedure.   

>>>>>>> 1fca63e0c561510496664c0e24ef9c2d299eff6e
