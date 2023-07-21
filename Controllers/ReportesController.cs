using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Identity;
using PDVreact.Models;
using PDVreact.DTOs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

namespace PDVreact.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class ReportesController : ControllerBase
    {
        private readonly WebApiContext _context;
        private readonly UserManager<Usuario> _userManager;

        public ReportesController(WebApiContext context, UserManager<Usuario> userManager)
        {
            _context = context;
            _userManager = userManager;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<ReporteDTO>>> GetReportes(DateTime inicio, DateTime fin)
        {
            var ventas = _context.Ventas
                .Where(v => v.Fecha >= inicio && v.Fecha <= fin)
                .Include(v => v.Usuario)
                .Include(v => v.Cliente)
                .Include(v => v.VentaProductos)
                .ThenInclude(vp => vp.Producto)
                .ThenInclude(p => p.Categoria)
                .ToList();

            if (ventas == null || !ventas.Any())
            {
                return NotFound("No hubo ventas en este periodo.");
            }

            var reporte = new Reporte
            {
                FechaInicio = inicio,
                FechaFin = fin
            };

            var reporteDTO = await MapToReporteDto(reporte);

            return new List<ReporteDTO> { reporteDTO };
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<ReporteDTO>> GetReporte(int id)
        {
            var reporte = await _context.Reportes.FirstOrDefaultAsync(r => r.Id == id);

            if (reporte == null)
            {
                return NotFound();
            }

            var reporteDTO = await MapToReporteDto(reporte);

            return reporteDTO;
        }


        [HttpPost]
        public async Task<ActionResult<ReporteDTO>> PostReporte(DateTime inicio, DateTime fin)
        {
            var ventas = await _context.Ventas
                .Where(v => v.Fecha >= inicio && v.Fecha <= fin)
                .Include(v => v.Usuario)
                .Include(v => v.Cliente)
                .Include(v => v.VentaProductos)
                .ThenInclude(vp => vp.Producto)
                .ThenInclude(p => p.Categoria)
                .ToListAsync();

            if (ventas == null || !ventas.Any())
            {
                return NotFound("No hubo ventas en este periodo.");
            }

            var reporte = new Reporte
            {
                FechaInicio = inicio,
                FechaFin = fin
            };

            var reporteDTO = await MapToReporteDto(reporte);

            return reporteDTO;
        }

        private async Task<ReporteDTO> MapToReporteDto(Reporte reporte)
        {
            var ventas = _context.Ventas
                .Where(v => v.Fecha >= reporte.FechaInicio && v.Fecha <= reporte.FechaFin)
                .Include(v => v.Usuario)
                .Include(v => v.Cliente)
                .Include(v => v.VentaProductos)
                .ThenInclude(vp => vp.Producto)
                .ThenInclude(p => p.Categoria)
                .ToList();

            List<VentaDTO> ventasDTO = new List<VentaDTO>();

            foreach (var venta in ventas)
            {
                var user = await _userManager.FindByIdAsync(venta.Usuario.Id);
                var roles = await _userManager.GetRolesAsync(user);

                var ventaDTO = new VentaDTO
                {
                    Id = venta.Id,
                    Cliente = new ClienteDTO
                    {
                        Id = venta.Cliente.Id,
                        Nombre = venta.Cliente.Nombre,
                        Direccion = venta.Cliente.Direccion,
                        Telefono = venta.Cliente.Telefono
                    },
                    Usuario = new UsuarioDTO
                    {
                        Id = user.Id,
                        Nombre = user.UserName,
                        Email = user.Email,
                        Rol = roles.FirstOrDefault()
                    },
                    VentaProductos = venta.VentaProductos.Select(vp => new VentaProductoDTO
                    {
                        VentaId = vp.VentaId,
                        ProductoId = vp.ProductoId,
                        Cantidad = vp.Cantidad
                    }).ToList(),
                    Total = venta.Total,
                    MetodoPago = venta.MetodoPago,
                    Fecha = venta.Fecha
                };

                ventasDTO.Add(ventaDTO);
            }

            var totalVentas = ventasDTO.Count;
            var ingresosTotales = ventasDTO.Sum(v => v.Total);
            var promedioVentas = totalVentas != 0 ? ingresosTotales / totalVentas : 0;

            var reporteDTO = new ReporteDTO
            {
                Id = reporte.Id,
                FechaInicio = reporte.FechaInicio,
                FechaFin = reporte.FechaFin,
                TotalVentas = totalVentas,
                IngresosTotales = ingresosTotales,
                PromedioVentas = promedioVentas,
                Ventas = ventasDTO
            };

            return reporteDTO;
        }


    }
}
