-- Agregar restricción de llave foránea a la tabla Producto
ALTER TABLE Producto
ADD CONSTRAINT fk_Producto_Categoria
FOREIGN KEY (categoria_id) REFERENCES Categoria(id);

-- Agregar restricción de llave foránea a la tabla Stock
ALTER TABLE Stock
ADD CONSTRAINT fk_Stock_Sucursal
FOREIGN KEY (sucursal_id) REFERENCES Sucursal(id),
ADD CONSTRAINT fk_Stock_Producto
FOREIGN KEY (producto_id) REFERENCES Producto(id);

-- Agregar restricción de llave foránea a la tabla Orden
ALTER TABLE Orden
ADD CONSTRAINT fk_Orden_Cliente
FOREIGN KEY (cliente_id) REFERENCES Cliente(id),
ADD CONSTRAINT fk_Orden_Sucursal
FOREIGN KEY (sucursal_id) REFERENCES Sucursal(id);

-- Agregar restricción de llave foránea a la tabla Item
ALTER TABLE Item
ADD CONSTRAINT fk_Item_Orden
FOREIGN KEY (orden_id) REFERENCES Orden(id),
ADD CONSTRAINT fk_Item_Producto
FOREIGN KEY (producto_id) REFERENCES Producto(id);

-- Consulta analítica 
-- Realizar consulta analíticas

-- Consulta analítica 1: Calcular el precio promedio de los productos en cada categoría
SELECT c.nombre AS nombre_categoria, AVG(p.precio) AS precio_promedio
FROM Categoria c
JOIN Producto p ON c.id = p.categoria_id
GROUP BY c.id;

-- Consulta analítica 2: Obtener la cantidad total de productos en stock por categoría
SELECT c.nombre AS nombre_categoria, SUM(s.cantidad) AS cantidad_total
FROM Categoria c
JOIN Producto p ON c.id = p.categoria_id
JOIN Stock s ON p.id = s.producto_id
GROUP BY c.id;

-- Consulta analítica 3: Calcular el total de ventas por sucursal
SELECT s.nombre AS nombre_sucursal, SUM(o.total) AS total_ventas
FROM Sucursal s
JOIN Orden o ON s.id = o.sucursal_id
GROUP BY s.id;

-- Consulta analítica 4: Obtener el cliente que ha realizado el mayor monto de compras
SELECT c.nombre AS nombre_cliente, SUM(o.total) AS monto_total
FROM Cliente c
JOIN Orden o ON c.id = o.cliente_id
GROUP BY c.id
ORDER BY monto_total DESC
LIMIT 1;
