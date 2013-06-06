def input param socket as utils.Socket.

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

