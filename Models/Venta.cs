namespace PDVreact.Models
{
    public class Venta
    {
        public int Id { get; set; }
        public Cliente Cliente { get; set; }
        public Usuario Usuario { get; set; }
        public List<VentaProducto> VentaProductos { get; set; }
        public decimal Total { get; set; }
        public string MetodoPago { get; set; }
        public DateTime Fecha { get; set; }
        public List<Pago> Pagos { get; set; } // Los pagos aplicados a esta venta
        public Factura Factura { get; set; } // La factura a la que pertenece esta venta
    }
}

