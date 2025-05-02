SELECT "nombre", TO_CHAR(created_at::date, 'dd/Mon/yyyy'), comentario
	FROM comentarios
	INNER JOIN "datosBlogs"
       ON "blogId" = session_id
	ORDER BY nombre;
		   