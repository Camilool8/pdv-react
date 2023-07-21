using System;
using System.Collections.Generic;

namespace PDVreact.Models
{
    public class Factura
    {
        public int Id { get; set; }
        public List<Venta> Ventas { get; set; } // Las ventas que incluye esta factura
        public DateTime Fecha { get; set; } // La fecha en que se generó la factura
        public decimal Total { get; set; } // El total de la factura
    }
}