INSERT INTO comentarios("blogId", comentario)
	SELECT session_id, 'siete-C' FROM "datosBlogs"
      WHERE nombre = 'Nohemy Cardona Claros'
RETURNING *;
