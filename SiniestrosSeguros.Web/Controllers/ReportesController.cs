using DocumentFormat.OpenXml;
using DocumentFormat.OpenXml.Drawing.Spreadsheet;
using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Spreadsheet;
using Microsoft.Reporting.WebForms;
using SiniestrosSeguros.BL;
using SiniestrosSeguros.BL.BLogic;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using static SiniestrosSeguros.DTO.ModelCustoms.Reportes;
using static SiniestrosSeguros.DTO.ModelCustoms.TipoPoliza;
using static SiniestrosSeguros.DTO.ModelViews.Reportes;


namespace SiniestrosSeguros.Web.Controllers
{
    public class ReportesController : Controller
    {

        Constante constanteBL = new Constante();
        Reporte reporteBL = new Reporte();
        TipoPoliza tipoPolizaBL = new TipoPoliza();
        Empresa empresaBL = new Empresa();

        // GET: Reportes
        public ActionResult Index()
        {

            return View();
        }

        //Metodos de ejemplo de reportes mediante .rdlc y reportViewer
        [AllowAnonymous]
        public ActionResult ReportViewer(string returnUrl)
        {
            string filtroPoliza = "TIPOLIZA";
            List<DTO.ModelCustoms.Constante.ConstanteComboView> listaDetalle = constanteBL.ListarDetalleConstante(filtroPoliza);
            ViewBag.ListaRamoPoliza = new SelectList(listaDetalle, "IdConstante", "Constante");
            ViewBag.ListaEmpresa = new SelectList(empresaBL.ListaEmpresas(), "IdEmpresa", "NombreCorto");
            ViewBag.ReturnUrl = returnUrl;
            return View(new RamoPolizaParamModelView());
        }

        [HttpPost]
        [AllowAnonymous]
        public ViewResult ReportViewer(RamoPolizaParamModelView um)
        {
            return View(um);
        }

        public ActionResult EscribeExcel(short IdConstante, int? IdEmpresa, string chkDetalle, DateTime? FechaInicio, DateTime? FechaFin)
        {
            Guid cName = Guid.NewGuid();
            string cNomArc = cName.ToString();
            string UrlArchivo = Convert.ToString(ConfigurationManager.AppSettings["UrlArchivo"]);
            string path = System.IO.Path.Combine(UrlArchivo, cNomArc + ".xlsx").ToString();

            short IdPatrimoniales = 2;
            short IdPersonales = 3;
            short IdVehiculo = 4;
            try
            {
                MemoryStream memoryStream = new MemoryStream();
                using (SpreadsheetDocument document = SpreadsheetDocument.Create(memoryStream, SpreadsheetDocumentType.Workbook))
                {
                    #region Instancia OpenXML 
                    WorkbookPart workbookPart = document.AddWorkbookPart();
                    workbookPart.Workbook = new Workbook();

                    WorksheetPart worksheetPart = workbookPart.AddNewPart<WorksheetPart>();
                    worksheetPart.Worksheet = new Worksheet();

                    WorkbookStylesPart stylesheet = document.WorkbookPart.AddNewPart<WorkbookStylesPart>();
                    stylesheet.Stylesheet = GenerateStyleSheet();
                    stylesheet.Stylesheet.Save();

                    Sheets sheets = workbookPart.Workbook.AppendChild(new DocumentFormat.OpenXml.Spreadsheet.Sheets());

                    Sheet sheet = new Sheet()
                    {
                        Id = workbookPart.GetIdOfPart(worksheetPart),
                        SheetId = 1,
                        Name = "Reporte"
                    };//Nombre de la hoja

                    sheets.Append(sheet);

                    workbookPart.Workbook.Save();

                    SheetData sheetData = worksheetPart.Worksheet.AppendChild(new SheetData());

                    Columns columns = new Columns();

                    columns.Append(new Column() { Min = 1, Max = 20, Width = 15, CustomWidth = true });
                    columns.Append(new Column() { Min = 1, Max = 20, Width = 15, CustomWidth = true });
                    columns.Append(new Column() { Min = 1, Max = 20, Width = 15, CustomWidth = true });
                    columns.Append(new Column() { Min = 1, Max = 20, Width = 15, CustomWidth = true });
                    columns.Append(new Column() { Min = 1, Max = 20, Width = 15, CustomWidth = true });

                    #endregion

                    LoadImage(worksheetPart.Worksheet, worksheetPart, workbookPart);
                    //Verificar si esta completo
                    #region Genera Header 
                    Row rowTitle = new Row()
                    {
                        RowIndex = 4
                    };

                    string titulo = "VALORES DECLARADOS - ";
                    List<Row> filas = null;
                    if (IdConstante == IdPatrimoniales)
                    {
                        titulo += "POLIZAS PATRIMONIALES";
                        filas = ReportePatrimoniales(IdPatrimoniales, IdEmpresa == null ? 0 : (short?)IdEmpresa, FechaInicio, FechaFin);
                    }
                    else if (IdConstante == IdPersonales)
                    {
                        titulo += "POLIZAS PERSONALES";
                        filas = ReportePersonales(IdPersonales, IdEmpresa == null ? 0 : (short?)IdEmpresa, FechaInicio, FechaFin);
                        worksheetPart.Worksheet.InsertBefore(columns, sheetData);
                    }
                    else if (IdConstante == IdVehiculo && chkDetalle == "n")
                    {
                        titulo += "POLIZA VEHICULOS";
                        filas = ReporteVehiculos(IdVehiculo, IdEmpresa == null ? 0 : (short?)IdEmpresa, FechaInicio, FechaFin);
                        worksheetPart.Worksheet.InsertBefore(columns, sheetData);
                    }
                    else if (chkDetalle == "s")
                    {
                        titulo += "DETALLE DE VEHICULOS";
                        filas = ReporteVehiculoDetalle(IdEmpresa == null ? (short)0 : (short)IdEmpresa, FechaInicio, FechaFin);
                        worksheetPart.Worksheet.InsertBefore(columns, sheetData);
                    }
                    //Inserta Titulo
                    Cell titleCell = ConstructCell(titulo, CellValues.String, 1);
                    rowTitle.Append(titleCell);
                    sheetData.AppendChild(rowTitle);
                    if (IdEmpresa > 0)
                    {
                        Row rowFilter = new Row() { RowIndex = 5 };
                        DTO.ModelCustoms.Empresa.Empresas empresa = (from e in empresaBL.ListaEmpresas().ToList()
                                                                     where e.IdEmpresa == IdEmpresa
                                                                     select e).FirstOrDefault();
                        Cell cellFilter = ConstructCell("Empresa: " + empresa.NombreCorto, CellValues.String, 5);
                        rowFilter.Append(cellFilter);
                        sheetData.AppendChild(rowFilter);
                    }
                    else if (FechaInicio != null)
                    {
                        Row rowFilter = new Row() { RowIndex = 5 };
                        Cell cellFilter = ConstructCell("Vigencia del " + FechaInicio.ToString() + " al " + FechaFin.ToString(), CellValues.String, 5);
                        rowFilter.Append(cellFilter);
                        sheetData.AppendChild(rowFilter);
                    }

                    #endregion

                    //Inserta datos
                    #region populateRow 
                    foreach (Row fila in filas)
                    {
                        sheetData.AppendChild(fila);
                    }
                    #endregion

                    MergeCells mergeCells = new MergeCells();

                    //append a MergeCell to the mergeCells for each set of merged cells
                    mergeCells.Append(new MergeCell() { Reference = new StringValue("A4:F4") });

                    worksheetPart.Worksheet.InsertAfter(mergeCells, worksheetPart.Worksheet.Elements<SheetData>().First());
                    worksheetPart.Worksheet.Save();
                }
                memoryStream.Seek(0, SeekOrigin.Begin);
                byte[] bytes = memoryStream.ToArray();
                Session["archivo"] = bytes;
                return null;
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        public void DescargaReporte()
        {
            byte[] arch = (byte[])Session["archivo"];

            Response.Clear();
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.AddHeader("content-disposition", "attachment;filename=" + "Reporte.xlsx");
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.BinaryWrite(arch);
            Response.End();
        }

        private Cell ConstructCell(string value, CellValues dataType)
        {
            return new Cell()
            {
                CellValue = new CellValue(value),
                DataType = new EnumValue<CellValues>(dataType)
            };
        }

        private Cell ConstructCell(string value, CellValues dataType, string cellReference)
        {
            return new Cell()
            {
                CellValue = new CellValue(value),
                DataType = new EnumValue<CellValues>(dataType),
                CellReference = cellReference
            };
        }

        private Cell ConstructCell(string value, CellValues dataType, UInt32 styleIndex)
        {
            return new Cell()
            {
                CellValue = new CellValue(value),
                DataType = new EnumValue<CellValues>(dataType),
                StyleIndex = styleIndex
            };
        }

        private Stylesheet GenerateStyleSheet()
        {
            return new Stylesheet(
              new DocumentFormat.OpenXml.Spreadsheet.Fonts(
                  new Font( // Titulos Reportes
                      new Bold(),
                      new FontSize() { Val = 14 },
                      new Color() { Rgb = new HexBinaryValue() { Value = "000000" } },
                      new FontName() { Val = "Arial" }),
                  new Font( // Titulos Cabeceras                                                             
                      new Bold(),
                      new FontSize() { Val = 11 },
                      new Color() { Rgb = new HexBinaryValue() { Value = "000000" } },
                      new FontName() { Val = "Arial" }),
                  new Font( // Datos                                                               
                      new FontSize() { Val = 10 },
                      new Color() { Rgb = new HexBinaryValue() { Value = "000000" } },
                      new FontName() { Val = "Arial" }),
                  new Font( // Totales
                      new Bold(),
                      new FontSize() { Val = 10 },
                      new Color() { Rgb = new HexBinaryValue() { Value = "000000" } },
                      new FontName() { Val = "Arial" })
              ),
              new Fills(
                  new DocumentFormat.OpenXml.Spreadsheet.Fill(                                                           // Index 0 - The default fill.
                      new DocumentFormat.OpenXml.Spreadsheet.PatternFill() { PatternType = PatternValues.None }),
                  new DocumentFormat.OpenXml.Spreadsheet.Fill(                                                           // Index 1 - The default fill of gray 125 (required)
                      new DocumentFormat.OpenXml.Spreadsheet.PatternFill() { PatternType = PatternValues.Gray125 }),
                  new DocumentFormat.OpenXml.Spreadsheet.Fill(                                                           // Index 2 - The yellow fill.
                      new DocumentFormat.OpenXml.Spreadsheet.PatternFill(
                          new DocumentFormat.OpenXml.Spreadsheet.ForegroundColor() { Rgb = new HexBinaryValue() { Value = "C0C0C0" } }
                      )
                      { PatternType = PatternValues.Solid })
              ),
              new Borders(
                  new Border(                                                         // Index 0 - The default border.
                      new DocumentFormat.OpenXml.Spreadsheet.LeftBorder(),
                      new DocumentFormat.OpenXml.Spreadsheet.RightBorder(),
                      new DocumentFormat.OpenXml.Spreadsheet.TopBorder(),
                      new DocumentFormat.OpenXml.Spreadsheet.BottomBorder(),
                      new DiagonalBorder()),
                  new Border(                                                         // Index 1 - Applies a Left, Right, Top, Bottom border to a cell
                      new DocumentFormat.OpenXml.Spreadsheet.LeftBorder(
                          new Color() { Auto = true }
                      )
                      { Style = BorderStyleValues.Thin },
                      new DocumentFormat.OpenXml.Spreadsheet.RightBorder(
                          new Color() { Auto = true }
                      )
                      { Style = BorderStyleValues.Thin },
                      new DocumentFormat.OpenXml.Spreadsheet.TopBorder(
                          new Color() { Auto = true }
                      )
                      { Style = BorderStyleValues.Thin },
                      new DocumentFormat.OpenXml.Spreadsheet.BottomBorder(
                          new Color() { Auto = true }
                      )
                      { Style = BorderStyleValues.Thin }),
                  new Border(                                                         // Index 2 - Applies a Left, Right, Top, Bottom border to a cell
                      new DocumentFormat.OpenXml.Spreadsheet.LeftBorder(
                          new Color() { Auto = true }
                      )
                      { Style = BorderStyleValues.Thick },
                      new DocumentFormat.OpenXml.Spreadsheet.RightBorder(
                          new Color() { Auto = true }
                      )
                      { Style = BorderStyleValues.Thick },
                      new DocumentFormat.OpenXml.Spreadsheet.TopBorder(
                          new Color() { Auto = true }
                      )
                      { Style = BorderStyleValues.Thick },
                      new DocumentFormat.OpenXml.Spreadsheet.BottomBorder(
                          new Color() { Auto = true }
                      )
                      { Style = BorderStyleValues.Thick })
              ),
              new CellFormats(
                  new CellFormat() { FontId = 0, FillId = 0, BorderId = 0 },
                  new CellFormat()
                  {
                      Alignment = new Alignment() { Horizontal = HorizontalAlignmentValues.Center },
                      FontId = 0,
                      FillId = 0,
                      BorderId = 0,
                      ApplyFont = true
                  }, // StyleIndex 1 - Titulo Reporte 
                  new CellFormat()
                  {
                      Alignment = new Alignment() { Horizontal = HorizontalAlignmentValues.Center, WrapText = true },
                      FontId = 1,
                      FillId = 2,
                      BorderId = 1,
                      ApplyFont = true,
                      ApplyBorder = true,
                      ApplyFill = true
                  }, // StyleIndex 2 - Titulo Cabeceras 
                  new CellFormat() { FontId = 2, FillId = 0, BorderId = 1, ApplyFont = true, ApplyBorder = true }, // StyleIndex 3 - Datos
                  new CellFormat() { FontId = 3, FillId = 0, BorderId = 2, ApplyFont = true, ApplyBorder = true }, // StyleIndex 4 - Totales
                  new CellFormat() { FontId = 1, FillId = 0, BorderId = 0, ApplyFont = true, ApplyBorder = false }, // StyleIndex 5 - Polizas
                  new CellFormat()
                  {
                      FontId = 3,
                      FillId = 0,
                      BorderId = 1,
                      ApplyFont = true,
                      ApplyBorder = true,
                      Alignment = new Alignment() { Horizontal = HorizontalAlignmentValues.Right, WrapText = true },
                  },
                  new CellFormat() { FontId = 3, FillId = 0, BorderId = 1, ApplyFont = true, ApplyBorder = true }
              )
          ); // return
        }

        private void LoadImage(Worksheet ws, WorksheetPart wsp, WorkbookPart wp)
        {
            string path = System.IO.Path.Combine(Server.MapPath("~/Scripts/Images"), "unnamed.png").ToString();
            DrawingsPart dp = wsp.AddNewPart<DrawingsPart>();
            ImagePart imgp = dp.AddImagePart(ImagePartType.Png, wsp.GetIdOfPart(dp));
            using (FileStream fs = new FileStream(path, FileMode.Open))
            {
                imgp.FeedData(fs);
            }

            NonVisualDrawingProperties nvdp = new NonVisualDrawingProperties();
            nvdp.Id = 1025;
            nvdp.Name = "Picture 1";
            nvdp.Description = "polymathlogo";
            DocumentFormat.OpenXml.Drawing.PictureLocks picLocks = new DocumentFormat.OpenXml.Drawing.PictureLocks();
            picLocks.NoChangeAspect = true;
            picLocks.NoChangeArrowheads = true;
            NonVisualPictureDrawingProperties nvpdp = new NonVisualPictureDrawingProperties();
            nvpdp.PictureLocks = picLocks;
            NonVisualPictureProperties nvpp = new NonVisualPictureProperties();
            nvpp.NonVisualDrawingProperties = nvdp;
            nvpp.NonVisualPictureDrawingProperties = nvpdp;

            DocumentFormat.OpenXml.Drawing.Stretch stretch = new DocumentFormat.OpenXml.Drawing.Stretch();
            stretch.FillRectangle = new DocumentFormat.OpenXml.Drawing.FillRectangle();

            BlipFill blipFill = new BlipFill();
            DocumentFormat.OpenXml.Drawing.Blip blip = new DocumentFormat.OpenXml.Drawing.Blip();
            blip.Embed = dp.GetIdOfPart(imgp);
            blip.CompressionState = DocumentFormat.OpenXml.Drawing.BlipCompressionValues.Print;
            blipFill.Blip = blip;
            blipFill.SourceRectangle = new DocumentFormat.OpenXml.Drawing.SourceRectangle();
            blipFill.Append(stretch);

            DocumentFormat.OpenXml.Drawing.Transform2D t2d = new DocumentFormat.OpenXml.Drawing.Transform2D();
            DocumentFormat.OpenXml.Drawing.Offset offset = new DocumentFormat.OpenXml.Drawing.Offset();
            offset.X = 0;
            offset.Y = 0;
            t2d.Offset = offset;
            System.Drawing.Bitmap bm = new System.Drawing.Bitmap(path);
            //http://en.wikipedia.org/wiki/English_Metric_Unit#DrawingML
            //http://stackoverflow.com/questions/1341930/pixel-to-centimeter
            //http://stackoverflow.com/questions/139655/how-to-convert-pixels-to-points-px-to-pt-in-net-c
            DocumentFormat.OpenXml.Drawing.Extents extents = new DocumentFormat.OpenXml.Drawing.Extents();
            extents.Cx = (long)bm.Width * (long)((float)914400 / bm.HorizontalResolution);
            extents.Cy = (long)bm.Height * (long)((float)914400 / bm.VerticalResolution);
            bm.Dispose();
            t2d.Extents = extents;
            ShapeProperties sp = new ShapeProperties();
            sp.BlackWhiteMode = DocumentFormat.OpenXml.Drawing.BlackWhiteModeValues.Auto;
            sp.Transform2D = t2d;
            DocumentFormat.OpenXml.Drawing.PresetGeometry prstGeom = new DocumentFormat.OpenXml.Drawing.PresetGeometry();
            prstGeom.Preset = DocumentFormat.OpenXml.Drawing.ShapeTypeValues.Rectangle;
            prstGeom.AdjustValueList = new DocumentFormat.OpenXml.Drawing.AdjustValueList();
            sp.Append(prstGeom);
            sp.Append(new DocumentFormat.OpenXml.Drawing.NoFill());

            DocumentFormat.OpenXml.Drawing.Spreadsheet.Picture picture = new DocumentFormat.OpenXml.Drawing.Spreadsheet.Picture();
            picture.NonVisualPictureProperties = nvpp;
            picture.BlipFill = blipFill;
            picture.ShapeProperties = sp;

            Position pos = new Position();
            pos.X = 0;
            pos.Y = 0;
            Extent ext = new Extent();
            ext.Cx = extents.Cx;
            ext.Cy = extents.Cy;
            AbsoluteAnchor anchor = new AbsoluteAnchor();
            anchor.Position = pos;
            anchor.Extent = ext;
            anchor.Append(picture);
            anchor.Append(new ClientData());
            WorksheetDrawing wsd = new WorksheetDrawing();
            wsd.Append(anchor);
            Drawing drawing = new Drawing();
            drawing.Id = dp.GetIdOfPart(imgp);

            wsd.Save(dp);
            ws.Append(drawing);
        }

        private List<Row> ReportePatrimoniales(short IdTipoPoliza, short? idEmpresa, DateTime? fechaInicio, DateTime? fechaFin)
        {
            decimal montoTotalPatrimonio = 0;
            List<Row> filas = new List<Row>();
            List<Patrimonial> lista = reporteBL.ObtenerInfoPatrimonial(IdTipoPoliza, idEmpresa, fechaInicio, fechaFin);
            List<TipoPolizaComboView> listaPolizas = (from t in tipoPolizaBL.ListarTiposPolizaPorRamoPoliza(IdTipoPoliza).ToList()
                                                      select new TipoPolizaComboView()
                                                      {
                                                          IdDivisionPoliza = t.IdDivisionPoliza,
                                                          Descripcion = t.Descripcion
                                                      }).ToList();
            UInt32 rowIndex = 7;
            foreach (TipoPolizaComboView poliza in listaPolizas)
            {
                bool existePreHeader = false;
                SortedList<short?, string> tiposValorDeclarado = new SortedList<short?, string>();
                SortedList<short?, decimal> valoresValorDeclarado = new SortedList<short?, decimal>();
                Dictionary<short?, string> empresas = new Dictionary<short?, string>();
                List<EmpresaTipoImporte> listaImportes = new List<EmpresaTipoImporte>();
                int auxMayorColumnas = -1;
                int IdEmpresaGanadora = 0;
                foreach (Patrimonial patrimonial in lista)
                {
                    string polizas = "Póliza ";
                    bool flag = poliza.IdDivisionPoliza == patrimonial.IdTipoPoliza;
                    if (!existePreHeader && flag)
                    {
                        Row rowPreHeader = new Row()
                        {
                            RowIndex = rowIndex
                        };
                        rowPreHeader.Append(ConstructCell(polizas + patrimonial.TipoPoliza, CellValues.String, 5));
                        rowIndex++;
                        existePreHeader = true;
                        filas.Add(rowPreHeader);

                    }

                    if (flag)
                    {

                        EmpresaTipoImporte empTipoImp = new EmpresaTipoImporte();
                        empTipoImp.IdEmpresa = patrimonial.IdEmpresa;
                        empTipoImp.IdTipoValorDeclarado = patrimonial.IdTipoValorDeclarado;
                        empTipoImp.Monto = patrimonial.Importe;
                        //Obtiene la lista de tipo valor declarado por importe
                        listaImportes.Add(empTipoImp);



                    }

                    if (flag && !tiposValorDeclarado.ContainsKey(patrimonial.IdTipoValorDeclarado))
                    {

                        tiposValorDeclarado.Add(patrimonial.IdTipoValorDeclarado, patrimonial.TipoValorDeclarado);
                        valoresValorDeclarado.Add(patrimonial.IdTipoValorDeclarado, patrimonial.Importe == null ? 0 : (decimal)patrimonial.Importe);



                    }

                    if (flag && !empresas.ContainsKey(patrimonial.IdEmpresa))
                    {
                        empresas.Add(patrimonial.IdEmpresa, patrimonial.Empresa);

                        //::> Empresas 


                    }
                }

                if (existePreHeader)
                {
                    Row rowHeaderPoliza = new Row();
                    rowHeaderPoliza.RowIndex = rowIndex;
                    rowHeaderPoliza.Append(ConstructCell("Empresas", CellValues.String, 2));
                    //Empresas con su tipo de valor declarado
                    foreach (var tipoValorDeclarado in tiposValorDeclarado.OrderBy(x => x.Key))
                    {
                        //valor cabecera fila
                        string valor = tipoValorDeclarado.Value == "" ? "0" : tipoValorDeclarado.Value;
                        rowHeaderPoliza.Append(ConstructCell(valor, CellValues.String, 2));
                    }
                    rowHeaderPoliza.Append(ConstructCell("Total", CellValues.String, 2));
                    filas.Add(rowHeaderPoliza);
                    rowIndex++;
                    //obtiene las columnas
                    short?[] columnasTipoValorDeclarado = tiposValorDeclarado.Keys.ToArray();
                    decimal?[] sumaValorDeclarado = new decimal?[columnasTipoValorDeclarado.Length];
                    for (int i = 0; i < sumaValorDeclarado.Length; i++)
                    {
                        sumaValorDeclarado[i] = 0;
                    }
                    Row rowData = null;

                    //Filas de las tablas
                    foreach (var empresa in empresas)
                    {
                        #region ObtenerEmpresaMayorColumna
                        //-> Las polizas que tienen el mismo requerimiento
                        var auxPolizas = lista.Where(x => x.IdTipoPoliza == poliza.IdDivisionPoliza).ToList();
                        //--> Columnas Actual de la empresa actual
                        int columnasActual = auxPolizas.Where(x => x.IdEmpresa == empresa.Key).Count();

                        #endregion

                        if (columnasActual < tiposValorDeclarado.Count)
                        {
                            foreach (var item in tiposValorDeclarado)
                            {
                                var cantidadExistente = listaImportes.Where(x => x.IdEmpresa == empresa.Key).ToList().Where(x => x.IdTipoValorDeclarado == item.Key).Count();
                                if (cantidadExistente == 0)
                                {
                                    EmpresaTipoImporte empTipoImp = new EmpresaTipoImporte();
                                    empTipoImp.IdEmpresa = empresa.Key;
                                    empTipoImp.IdTipoValorDeclarado = item.Key;
                                    empTipoImp.Monto = 0;
                                    //Obtiene la lista de tipo valor declarado por importe
                                    listaImportes.Add(empTipoImp);

                                }
                            }
                        }

                        int k = 0;
                        int ultimaColumna = 0;
                        decimal? totalEmpresa = 0;
                        rowData = new Row();
                        rowData.RowIndex = rowIndex;
                        //--> Obtiene nombre empresa
                        rowData.Append(ConstructCell(empresa.Value == "" ? "" : empresa.Value, CellValues.String, 3));
                        var importes = listaImportes.Where(x => x.IdEmpresa == empresa.Key).ToList().OrderBy(x => x.IdTipoValorDeclarado);
                        decimal? totalPatrimonial = 0;
                        foreach (var item in importes)
                        {

                            totalEmpresa += item.Monto;
                            for (int i = 0; i < columnasTipoValorDeclarado.Length; i++)
                            {
                                if (columnasTipoValorDeclarado[i] == item.IdTipoValorDeclarado)
                                {
                                    var valormonto = item.Monto;
                                    rowData.Append(ConstructCell(((item.Monto == null || valormonto == 0) ? "0" : decimal.Parse(valormonto.ToString()).ToString("N")), CellValues.Number, 6));
                                    sumaValorDeclarado[i] += valormonto;
                                }
                                ultimaColumna = i;
                            }
                        }
                        totalPatrimonial += totalEmpresa;
                        rowData.Append(ConstructCell(totalEmpresa == null ? "0" : ((decimal)totalEmpresa).ToString("N"), CellValues.Number, 6));
                        filas.Add(rowData);
                        rowIndex++;
                    }
                    rowData = new Row();
                    rowData.RowIndex = rowIndex;
                    rowData.Append(ConstructCell("Total", CellValues.String, 4));
                    decimal? montoTotalPoliza = 0;
                    for (int i = 0; i < sumaValorDeclarado.Length; i++)
                    {
                        rowData.Append(ConstructCell(sumaValorDeclarado[i] == null ? "0" : ((decimal)sumaValorDeclarado[i]).ToString("N"), CellValues.Number, 6));
                        montoTotalPoliza += sumaValorDeclarado[i];

                    }
                    montoTotalPatrimonio += montoTotalPoliza == null ? 0 : (decimal)montoTotalPoliza;
                    rowData.Append(ConstructCell(Convert.ToDecimal(montoTotalPoliza).ToString("N"), CellValues.Number, 6));
                    filas.Add(rowData);

                    rowIndex += 3;
                }
            }

            filas.Add(new Row());
            filas.Add(new Row());
            filas.Add(new Row());
            Row rowFooter = new Row();
            rowFooter.Append(ConstructCell("", CellValues.String, 5));
            rowFooter.Append(ConstructCell("", CellValues.String, 5));
            rowFooter.Append(ConstructCell("", CellValues.String, 5));
            rowFooter.Append(ConstructCell("Total", CellValues.String, 4));
            var totalCeel = new Cell
            {
                CellValue = new CellValue("S/ " + montoTotalPatrimonio.ToString("N")),
                DataType = CellValues.String,
                StyleIndex = 4,
            };
            rowFooter.Append(totalCeel);
            filas.Add(rowFooter);
            return filas;
        }

        private List<Row> ReportePersonales(short IdTipoPoliza, short? idEmpresa, DateTime? fechaInicio, DateTime? fechaFin)
        {
            List<Row> filas = new List<Row>();

            Row rowHeader = new Row()
            {
                RowIndex = 7
            };
            rowHeader.Append(ConstructCell("Empresas", CellValues.String, 2));
            rowHeader.Append(ConstructCell("N° de trabajadores", CellValues.String, 2));
            rowHeader.Append(ConstructCell("Monto de Planilla de Remuneraciones (S/.)", CellValues.String, 2));
            rowHeader.Append(ConstructCell("N° de practicantes", CellValues.String, 2));
            rowHeader.Append(ConstructCell("Monto de Planilla de Practicantes (S/.)", CellValues.String, 2));
            filas.Add(rowHeader);

            List<Personal> lista = reporteBL.ObtenerInfoPersonal(IdTipoPoliza, idEmpresa, fechaInicio, fechaFin);
            foreach (Personal personal in lista)
            {
                Row rowData = new Row();
                rowData.Append(ConstructCell(personal.Empresa, CellValues.String, 3));
                rowData.Append(ConstructCell(personal.NumTrabajadores.ToString(), CellValues.Number, 3));
                rowData.Append(ConstructCell(personal.MontoTrabajadores == null ? "0" : Convert.ToDecimal(personal.MontoTrabajadores).ToString("N"), CellValues.Number, 6));
                rowData.Append(ConstructCell(personal.NumPracticantes.ToString(), CellValues.Number, 3));
                rowData.Append(ConstructCell(personal.MontoPracticantes == null ? "0" : Convert.ToDecimal(personal.MontoPracticantes).ToString("N"), CellValues.Number, 6));
                filas.Add(rowData);
            }

            return filas;
        }

        private List<Row> ReporteVehiculos(short IdTipoPoliza, short? idEmpresa, DateTime? fechaInicio, DateTime? fechaFin)
        {
            decimal sumaAsegurada = 0;
            List<Row> filas = new List<Row>();
            Row rowHeader = new Row()
            {
                RowIndex = 7
            };
            rowHeader.Append(ConstructCell("Empresas", CellValues.String, 2));
            rowHeader.Append(ConstructCell("Cantidades Vehículos", CellValues.String, 2));
            rowHeader.Append(ConstructCell("Suma Asegurada", CellValues.String, 2));
            filas.Add(rowHeader);



            IEnumerable<DTO.ModelCustoms.Reportes.Vehiculo> lista = reporteBL.ObtenerInfoVehiculo(IdTipoPoliza, idEmpresa, fechaInicio, fechaFin);

            foreach (DTO.ModelCustoms.Reportes.Vehiculo vehiculo in lista)
            {
                sumaAsegurada += (decimal)vehiculo.MontoAsegurado;
                Row rowData = new Row();
                rowData.Append(ConstructCell(vehiculo.Empresa, CellValues.String, 3));
                rowData.Append(ConstructCell(vehiculo.NumVehiculo.ToString(), CellValues.Number, 3));
                rowData.Append(ConstructCell(vehiculo.MontoAsegurado == null ? "0" : Convert.ToDecimal(vehiculo.MontoAsegurado).ToString("N"), CellValues.String, 6));
                filas.Add(rowData);
            }
            Row rowFooter = new Row();
            rowFooter.Append(ConstructCell("TOTAL", CellValues.String, 7));
            rowFooter.Append(ConstructCell("", CellValues.String, 7));
            var totalCeel = new Cell
            {
                CellValue = new CellValue("S/ " + sumaAsegurada.ToString("N")),
                DataType = CellValues.String,
                StyleIndex = 6,
            };
            rowFooter.Append(totalCeel);
            filas.Add(rowFooter);

            return filas;
        }

        private List<Row> ReporteVehiculoDetalle(short IdEmpresa, DateTime? fechaInicio, DateTime? fechaFin)
        {
            List<Row> filas = new List<Row>();
            Row rowHeader = new Row()
            {
                RowIndex = 7
            };
            rowHeader.Append(ConstructCell("Descripción", CellValues.String, 2));
            rowHeader.Append(ConstructCell("Cantidades", CellValues.String, 2));
            rowHeader.Append(ConstructCell("Suma Asegurada", CellValues.String, 2));
            filas.Add(rowHeader);


            decimal sumaAsegurada = 0;
            List<DetalleVehiculo> lista = reporteBL.ObtenerInfoVehiculoDetalle(IdEmpresa, fechaInicio, fechaFin);

            foreach (DetalleVehiculo detalle in lista)
            {
                sumaAsegurada += (decimal)detalle.MontoAsegurado;
                Row rowData = new Row();
                rowData.Append(ConstructCell(detalle.Descripcion, CellValues.String, 3));
                rowData.Append(ConstructCell(detalle.Cantidad.ToString(), CellValues.Number, 3));
                rowData.Append(ConstructCell(detalle.MontoAsegurado == null ? "0" : Convert.ToDecimal(detalle.MontoAsegurado).ToString("N"), CellValues.Number, 6));
                filas.Add(rowData);
            }
            Row rowFooter = new Row();
            rowFooter.Append(ConstructCell("Total", CellValues.String, 7));
            rowFooter.Append(ConstructCell("", CellValues.String, 7));
            var totalCeel = new Cell
            {
                CellValue = new CellValue("S/ " + sumaAsegurada.ToString("N")),
                DataType = CellValues.String,
                StyleIndex = 6,
            };
            rowFooter.Append(totalCeel);
            filas.Add(rowFooter);
            return filas;
        }

    }
}