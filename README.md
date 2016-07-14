# Templator
Textgenerator from csv-files using template strings
## Install
```powershell
$ git clone https://github.com/alveflo/Templator.git
$ New-Alias -Name Templator -Value <path>\templator.ps1
```

## Usage
```powershell
$ Templator -CsvFile <file> (-Template <str> | -TemplateFile <file>)
```
### Example
The following example generates SQL `INSERT` statements.

`template.txt`:
```
INSERT INTO [dbo].[Table] ([Id], [City], [Country])
  VALUES ({{Id}}, {{City}}, {{Country}})
```

`data.csv`:
```
Id,City,Country
1,Stockholm,Sweden
2,Copenhagen,Denmark
3,Oslo,Norway
4,Helsinki,Finland
5,Berlin,Germany
6,Vienna,Austria
7,Amsterdam,Netherlands
8,Paris,France
```
Calling Templator with
```powershell
.\Templator.ps1 -CsvFile data.csv -TemplateFile template.txt
```
Gives following result file:
`Result file`:
```sql
INSERT INTO [dbo].[Table] ([Id], [City], [Country]) VALUES (1, Stockholm, Sweden)
INSERT INTO [dbo].[Table] ([Id], [City], [Country]) VALUES (2, Copenhagen, Denmark)
INSERT INTO [dbo].[Table] ([Id], [City], [Country]) VALUES (3, Oslo, Norway)
INSERT INTO [dbo].[Table] ([Id], [City], [Country]) VALUES (4, Helsinki, Finland)
INSERT INTO [dbo].[Table] ([Id], [City], [Country]) VALUES (5, Berlin, Germany)
INSERT INTO [dbo].[Table] ([Id], [City], [Country]) VALUES (6, Vienna, Austria)
INSERT INTO [dbo].[Table] ([Id], [City], [Country]) VALUES (7, Amsterdam, Netherlands)
INSERT INTO [dbo].[Table] ([Id], [City], [Country]) VALUES (8, Paris, France)
```
## License
MIT
