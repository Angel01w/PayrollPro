using System;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Nominas.DB;
using Nominas.Models;
using QuestPDF.Fluent;
using QuestPDF.Helpers;
using QuestPDF.Infrastructure;

namespace Nominas.Controllers
{
    public class EmpleadosController : Controller
    {
        private readonly AplicationDBContext _context;
        private readonly IWebHostEnvironment _host;

        public EmpleadosController(AplicationDBContext context, IWebHostEnvironment host)
        {
            _context = context;
            _host = host;
        }

        // GET: Empleados
        public async Task<IActionResult> Index()
        {
            return View(await _context.empleados.ToListAsync());
        }

        public IActionResult DescargarPDF()
        {
            var empleados = _context.empleados.ToList();

            var data = Document.Create(document =>
            {
                document.Page(page =>
                {
                    page.Margin(40);
                    page.PageColor(Colors.White);
                    page.Size(PageSizes.A4);

                    // Header
                    page.Header().Row(row =>
                    {
                        var rutaImagen = Path.Combine(_host.WebRootPath, "images/VisualStudio.png");
                        byte[] imageData = System.IO.File.ReadAllBytes(rutaImagen);
                        row.ConstantItem(100).Image(imageData);

                        row.RelativeItem().Column(col =>
                        {
                            col.Item().AlignCenter().Text("Nombre de la Empresa").Bold().FontSize(20);
                            col.Item().AlignCenter().Text("Dirección de la Empresa").FontSize(10);
                            col.Item().AlignCenter().Text("Teléfono de la Empresa").FontSize(10);
                            col.Item().AlignCenter().Text("Correo de la Empresa").FontSize(10);
                        });

                        row.RelativeItem().Column(col =>
                        {
                            col.Item().Border(1).BorderColor("#257272")
                            .AlignCenter().Text("RUC 123456789").Bold();

                            col.Item().Background("#257272").Border(1)
                            .BorderColor("#257272").AlignCenter()
                            .Text("Reporte de Empleados").FontColor("#fff").FontSize(12).Bold();

                            col.Item().Border(1).BorderColor("#257272")
                            .AlignCenter().Text(DateTime.Now.ToString("yyyy-MM-dd")).FontSize(10);
                        });
                    });

                    // Content
                    page.Content().PaddingVertical(20).Column(col1 =>
                    {
                        col1.Spacing(5);

                        col1.Item().Text("Datos de los Empleados").Underline().Bold().FontSize(16);

                        // Tabla de empleados
                        col1.Item().Table(table =>
                        {
                            table.ColumnsDefinition(columns =>
                            {
                                columns.RelativeColumn(1);
                                columns.RelativeColumn(2);
                                columns.RelativeColumn(1);
                                columns.RelativeColumn(1);
                                columns.RelativeColumn(1);
                            });

                            // Header
                            table.Header(header =>
                            {
                                header.Cell().Background("#257272").Padding(5).Text("ID").FontColor("#fff").Bold();
                                header.Cell().Background("#257272").Padding(5).Text("Nombre").FontColor("#fff").Bold();
                                header.Cell().Background("#257272").Padding(5).Text("Cédula").FontColor("#fff").Bold();
                                header.Cell().Background("#257272").Padding(5).Text("Departamento").FontColor("#fff").Bold();
                                header.Cell().Background("#257272").Padding(5).Text("Salario").FontColor("#fff").Bold();
                            });

                            // Rows
                            foreach (var empleado in empleados)
                            {
                                table.Cell().Padding(5).Text(empleado.id.ToString());
                                table.Cell().Padding(5).Text(empleado.Nombre);
                                table.Cell().Padding(5).Text(empleado.Cedula);
                                table.Cell().Padding(5).Text(empleado.id_Departamento.ToString());
                                table.Cell().Padding(5).Text(empleado.Salario.ToString("C"));
                            }
                        });

                        col1.Spacing(20);

                        // Comentarios o notas adicionales
                        col1.Item().Background(Colors.Grey.Lighten3).Padding(10).Column(column =>
                        {
                            column.Item().Text("Comentarios").FontSize(14).Bold();
                            column.Item().Text("Aquí puedes añadir cualquier comentario adicional o nota relevante sobre los empleados.");
                        });
                    });

                    // Footer
                    page.Footer().AlignRight().Text(txt =>
                    {
                        txt.Span("Página ").FontSize(10);
                        txt.CurrentPageNumber().FontSize(10);
                        txt.Span(" de ").FontSize(10);
                        txt.TotalPages().FontSize(10);
                    });
                });
            }).GeneratePdf();

            Stream stream = new MemoryStream(data);
            return File(stream, "application/pdf", "reporte_empleados.pdf");
        }

        // Otros métodos del controlador...

        // GET: Empleados/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var empleados = await _context.empleados
                .FirstOrDefaultAsync(m => m.id == id);
            if (empleados == null)
            {
                return NotFound();
            }

            return View(empleados);
        }

        // GET: Empleados/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: Empleados/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("id,Cedula,Nombre,id_Departamento,id_puesto,Salario,id_tipo_ingreso")] Empleados empleados)
        {
            if (ModelState.IsValid)
            {
                _context.Add(empleados);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(empleados);
        }

        // GET: Empleados/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var empleados = await _context.empleados.FindAsync(id);
            if (empleados == null)
            {
                return NotFound();
            }
            return View(empleados);
        }

        // POST: Empleados/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("id,Cedula,Nombre,id_Departamento,id_puesto,Salario,id_tipo_ingreso")] Empleados empleados)
        {
            if (id != empleados.id)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(empleados);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!EmpleadosExists(empleados.id))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Index));
            }
            return View(empleados);
        }

        // GET: Empleados/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var empleados = await _context.empleados
                .FirstOrDefaultAsync(m => m.id == id);
            if (empleados == null)
            {
                return NotFound();
            }

            return View(empleados);
        }

        // POST: Empleados/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var empleados = await _context.empleados.FindAsync(id);
            if (empleados != null)
            {
                _context.empleados.Remove(empleados);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool EmpleadosExists(int id)
        {
            return _context.empleados.Any(e => e.id == id);
        }
    }
}
