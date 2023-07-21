// Models/Pago.cs
using System;

namespace PDVreact.Models
{
    public class Pago
    {
        public int Id { get; set; }
        public Venta Venta { get; set; } // La venta a la que se aplica este pago
        public decimal Monto { get; set; } // El monto del pago
        public DateTime Fecha { get; set; } // La fecha en que se realizó el pago
    }
}