namespace PDVreact.DTOs
{
    public class VentaCreateDTO
    {
        public int ClienteId { get; set; }
        public string UsuarioId { get; set; }
        public List<VentaProductoCreateDTO> VentaProductos { get; set; }
        public decimal Total { get; set; }
        public string MetodoPago { get; set; }
    }
}
