CREATE procedure [dbo].[Test12345] as  
begin  
set nocount on 
--#region Namespaces
--using System;
--using System.IO;
--using System.Text;
--using Microsoft.SqlServer.Dts.Runtime;
----#endregion
--namespace ST_MHTML_Base64_To_HTML
--{
--    [Microsoft.SqlServer.Dts.Tasks.ScriptTask.SSISScriptTaskEntryPointAttribute]
--    public partial class ScriptMain :
--        Microsoft.SqlServer.Dts.Tasks.ScriptTask.VSTARTScriptObjectModelBase
--    {
--        public void Main()
--        {
--            try
--            {
--                string inputFile = @"C:\Reports\report.mhtml";
--                string outputFile = @"C:\Reports\report.html";

--                string content = File.ReadAllText(inputFile);

--                // Find HTML section header
--                int headerIndex = content.IndexOf("Content-Type: text/html", StringComparison.OrdinalIgnoreCase);

--                if (headerIndex < 0)
--                {
--                    Dts.Events.FireError(0, "MHTML Conversion",
--                        "HTML section not found.", "", 0);
--                    Dts.TaskResult = (int)ScriptResults.Failure;
--                    return;
--                }

--                // Find start of Base64 data (after blank line)
--                int dataStart = content.IndexOf("\r\n\r\n", headerIndex);
--                if (dataStart < 0)
--                {
--                    Dts.Events.FireError(0, "MHTML Conversion",
--                        "Base64 section not found.", "", 0);
--                    Dts.TaskResult = (int)ScriptResults.Failure;
--                    return;
--                }

--                dataStart += 4;

--                // Find next MIME boundary
--                int boundaryIndex = content.IndexOf("\r\n--", dataStart);
--                if (boundaryIndex < 0)
--                    boundaryIndex = content.Length;

--                string base64Data = content.Substring(dataStart, boundaryIndex - dataStart);

--                // Remove line breaks
--                base64Data = base64Data.Replace("\r", "").Replace("\n", "").Trim();

--                // Decode Base64
--                byte[] htmlBytes = Convert.FromBase64String(base64Data);
--                string htmlContent = Encoding.UTF8.GetString(htmlBytes);

--                // Save HTML file
--                File.WriteAllText(outputFile, htmlContent, Encoding.UTF8);

--                bool fireAgain = false;
--                Dts.Events.FireInformation(0, "MHTML Conversion",
--                    "HTML extracted successfully (Base64 decoded).", "", 0, ref fireAgain);

--                Dts.TaskResult = (int)ScriptResults.Success;
--            }
--            catch (Exception ex)
--            {
--                Dts.Events.FireError(0, "MHTML to HTML Error", ex.Message, "", 0);
--                Dts.TaskResult = (int)ScriptResults.Failure;
--            }
--        }

--        enum ScriptResults
--        {
--            Success = Microsoft.SqlServer.Dts.Runtime.DTSExecResult.Success,
--            Failure = Microsoft.SqlServer.Dts.Runtime.DTSExecResult.Failure
--        }
--    }
--}



end

GO

