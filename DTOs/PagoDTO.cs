// DTOs/PagoDTO.cs
using System;

namespace PDVreact.DTOs
{
    public class PagoDTO
    {
        public int Id { get; set; }
        public VentaDTO Venta { get; set; }
        public decimal Monto { get; set; }
        public DateTime Fecha { get; set; }
    }
}