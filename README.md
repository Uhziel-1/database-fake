Rellenar la data.

| Campo          | Tipo          | Descripción                                               | Opcional |
|----------------|---------------|----------------------------------------------------------|----------|
| id             | INT           | Identificador único para cada registro de auditoría      | No       |
| table_name     | VARCHAR       | Nombre de la tabla auditada                              | No       |
| record_id      | INT           | Identificador del registro en la tabla auditada          | No       |
| action         | VARCHAR       | Tipo de acción realizada (INSERT, UPDATE, DELETE)       | No       |
| created_at     | DATETIME      | Fecha y hora en que se registró la auditoría           | No       |
| updated_at     | DATETIME      | Fecha y hora de la última modificación del registro      | Sí       |
| user_id        | INT           | Identificador del usuario que realizó la acción          | Sí       |
| old_values     | TEXT          | Valores anteriores del registro (formato JSON/texto)     | Sí       |
| new_values     | TEXT          | Nuevos valores del registro (formato JSON/texto)         | Sí       |
| ip_address     | VARCHAR       | Dirección IP del usuario que realizó la acción           | Sí       |
| session_id     | VARCHAR       | Identificador de la sesión del usuario                   | Sí       |
| user_agent     | VARCHAR       | Información sobre el navegador o cliente del usuario     | Sí       |
| status         | VARCHAR       | Estado de la acción (success, failed)                    | Sí       |
| comments       | TEXT          | Notas sobre la acción                                    | Sí       |
| transaction_id | INT           | Identificador de la transacción (si aplica)              | Sí       |
| entity_type    | VARCHAR       | Tipo de entidad a la que pertenece el registro           | Sí       |
| reason         | TEXT          | Motivo de la modificación (si aplica)                    | Sí       |
| location       | VARCHAR       | Ubicación geográfica del usuario                          | Sí       |
| additional_info | TEXT         | Información adicional relevante                           | Sí       |
