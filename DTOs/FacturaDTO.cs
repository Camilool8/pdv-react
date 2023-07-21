// DTOs/FacturaDTO.cs
using System;
using System.Collections.Generic;

namespace PDVreact.DTOs
{
    public class FacturaDTO
    {
        public int Id { get; set; }
        public List<VentaDTO> Ventas { get; set; }
        public DateTime Fecha { get; set; }
        public decimal Total { get; set; }
    }
}