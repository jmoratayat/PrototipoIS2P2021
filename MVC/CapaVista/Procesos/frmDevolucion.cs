using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace CapaVista.Procesos
{
    public partial class frmDevolucion : Form
    {
        string UsuarioAplicacion;
        public frmDevolucion(string usuario)
        {
            InitializeComponent();
            fecha();
            UsuarioAplicacion = usuario;
        }
        private void fecha()
        {
            label6.Text = DateTime.Now.ToShortDateString();
        }

        private void frmDevolucion_Load(object sender, EventArgs e)
        {

        }
    }
}
