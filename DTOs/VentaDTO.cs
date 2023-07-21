namespace PDVreact.DTOs
{
    public class VentaDTO
    {
        public int Id { get; set; }
        public ClienteDTO Cliente { get; set; }
        public UsuarioDTO Usuario { get; set; }
        public List<VentaProductoDTO> VentaProductos { get; set; }
        public decimal Total { get; set; }
        public string MetodoPago { get; set; }
        public DateTime Fecha { get; set; }
        public List<PagoDTO> Pagos { get; set; }
        public FacturaDTO Factura { get; set; }
    }

}
