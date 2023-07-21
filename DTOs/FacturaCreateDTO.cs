namespace PDVreact.DTOs
{
    public class FacturaCreateDTO
    {
        public List<int> VentasIds { get; set; }
        public decimal Total { get; set; }
    }
}
