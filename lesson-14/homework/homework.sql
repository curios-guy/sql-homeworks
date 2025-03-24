declare @html nvarchar(max);
declare @table_rows nvarchar(max);

set @table_rows = 
    (select string_agg(
        '<tr>
            <td>' + t.name + '</td>
            <td>' + i.name + '</td>
            <td>' + i.type_desc + '</td>
            <td>' + c.name + '</td>
            <td>' + ty.name + '</td>
        </tr>', '') 
    from sys.indexes i
    inner join sys.tables t on i.object_id = t.object_id
    inner join sys.index_columns ic on i.object_id = ic.object_id and i.index_id = ic.index_id
    inner join sys.columns c on ic.object_id = c.object_id and ic.column_id = c.column_id
    inner join sys.types ty on c.user_type_id = ty.user_type_id
    where i.type > 0);  -- exclude heap indexes

-- construct full html content
set @html = 
    n'<html>
    <head>
        <style>
            table { border-collapse: collapse; width: 100%; font-family: Arial, sans-serif; }
            th, td { border: 1px solid black; padding: 8px; text-align: left; }
            th { background-color: #f2f2f2; }
        </style>
    </head>
    <body>
    <h2>index metadata report</h2>
    <table>
        <tr>
            <th>table name</th>
            <th>index name</th>
            <th>index type</th>
            <th>column name</th>
            <th>column type</th>
        </tr>' 
    + isnull(@table_rows, '') + 
    n'</table>
    </body>
    </html>';

-- send email using database mail
exec msdb.dbo.sp_send_dbmail
    @profile_name = 'yourdatabasemailprofile',  -- change to your database mail profile name
    @recipients = 'recipient@example.com',  -- change to recipient's email
    @subject = 'index metadata report',
    @body = @html,
    @body_format = 'html';