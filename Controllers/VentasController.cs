using System;
using System.Linq;
using System.Collections.Generic;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using AutoMapper;
using PDVreact.DTOs;
using PDVreact.Models;

[ApiController]
[Route("[controller]")]
public class VentasController : ControllerBase
{
    private readonly WebApiContext _context;
    private readonly IMapper _mapper;

    public VentasController(WebApiContext context, IMapper mapper)
    {
        _context = context;
        _mapper = mapper;
    }

    // GET: /Ventas
    [HttpGet]
    public async Task<ActionResult<IEnumerable<VentaDTO>>> GetVentas()
    {
        var ventas = await _context.Ventas.Include(v => v.Cliente)
                                          .Include(v => v.Usuario)
                                          .Include(v => v.VentaProductos)
                                          .ThenInclude(vp => vp.Producto)
                                          .Include(v => v.Pagos)
                                          .Include(v => v.Factura)
                                          .ToListAsync();
        return _mapper.Map<List<VentaDTO>>(ventas);
    }

    // GET: /Ventas/5
    [HttpGet("{id}")]
    public async Task<ActionResult<VentaDTO>> GetVenta(int id)
    {
        var venta = await _context.Ventas.Include(v => v.Cliente)
                                          .Include(v => v.Usuario)
                                          .Include(v => v.VentaProductos)
                                          .ThenInclude(vp => vp.Producto)
                                          .Include(v => v.Pagos)
                                          .Include(v => v.Factura)
                                          .FirstOrDefaultAsync(v => v.Id == id);

        if (venta == null)
        {
            return NotFound();
        }

        return _mapper.Map<VentaDTO>(venta);
    }

    // POST: /Ventas
    [HttpPost]
    public async Task<ActionResult<VentaDTO>> PostVenta(VentaCreateDTO ventaCreateDTO)
    {
        // Mapear VentaCreateDTO a Venta
        var venta = _mapper.Map<Venta>(ventaCreateDTO);
        _context.Ventas.Add(venta);
        await _context.SaveChangesAsync();

        // Mapear Venta a VentaDTO para la respuesta
        var ventaDTO = _mapper.Map<VentaDTO>(venta);

        return CreatedAtAction("GetVenta", new { id = ventaDTO.Id }, ventaDTO);
    }

    // Facturas

    // GET: /Ventas/Facturas
    [HttpGet("Facturas")]
    public async Task<ActionResult<IEnumerable<FacturaDTO>>> GetFacturas()
    {
        var facturas = await _context.Facturas.Include(f => f.Ventas)
                                              .ToListAsync();
        return _mapper.Map<List<FacturaDTO>>(facturas);
    }

    // GET: /Ventas/Facturas/5
    [HttpGet("Facturas/{id}")]
    public async Task<ActionResult<FacturaDTO>> GetFactura(int id)
    {
        var factura = await _context.Facturas.Include(f => f.Ventas)
                                             .FirstOrDefaultAsync(f => f.Id == id);

        if (factura == null)
        {
            return NotFound();
        }

        return _mapper.Map<FacturaDTO>(factura);
    }

    // POST: /Ventas/Facturas
    [HttpPost("Facturas")]
    public async Task<ActionResult<FacturaDTO>> PostFactura(FacturaCreateDTO facturaCreateDTO)
    {
        // Mapear FacturaCreateDTO a Factura
        var factura = _mapper.Map<Factura>(facturaCreateDTO);
        _context.Facturas.Add(factura);
        await _context.SaveChangesAsync();

        // Mapear Factura a FacturaDTO para la respuesta
        var facturaDTO = _mapper.Map<FacturaDTO>(factura);

        return CreatedAtAction("GetFactura", new { id = facturaDTO.Id }, facturaDTO);
    }

    // Pagos

    // GET: /Ventas/Pagos
    [HttpGet("Pagos")]
    public async Task<ActionResult<IEnumerable<PagoDTO>>> GetPagos()
    {
        var pagos = await _context.Pagos.Include(p => p.Venta)
                                        .ToListAsync();
        return _mapper.Map<List<PagoDTO>>(pagos);
    }

    // GET: /Ventas/Pagos/5
    [HttpGet("Pagos/{id}")]
    public async Task<ActionResult<PagoDTO>> GetPago(int id)
    {
        var pago = await _context.Pagos.Include(p => p.Venta)
                                       .FirstOrDefaultAsync(p => p.Id == id);

        if (pago == null)
        {
            return NotFound();
        }

        return _mapper.Map<PagoDTO>(pago);
    }

    // POST: /Ventas/Pagos
    [HttpPost("Pagos")]
    public async Task<ActionResult<PagoDTO>> PostPago(PagoCreateDTO pagoCreateDTO)
    {
        // Mapear PagoCreateDTO a Pago
        var pago = _mapper.Map<Pago>(pagoCreateDTO);
        _context.Pagos.Add(pago);
        await _context.SaveChangesAsync();

        // Mapear Pago a PagoDTO para la respuesta
        var pagoDTO = _mapper.Map<PagoDTO>(pago);

        return CreatedAtAction("GetPago", new { id = pagoDTO.Id }, pagoDTO);
    }
}
