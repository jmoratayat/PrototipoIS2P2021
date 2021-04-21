using CapaControlador;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.Odbc;
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
        Controlador controlador = new Controlador();
        string estado = "3";
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

        private void btnBuscar_Click(object sender, EventArgs e)
        {
            buscarE();
            buscarD();
                if (estado == "1")
            {
                lblEstado.Text = "EXISTENTE";
                fechaMora();
            }
            else if (estado=="0")
            {
                lblEstado.Text = "Ya entregada";
                btnEntregar.Visible = false;
            }
            else
            {
                lblEstado.Text = "NO Valida";
            }
        }
        private void fechaMora()
        {
            DateTime dt1 = DateTime.Parse(lblFechaEntrega.Text);
            DateTime dt2 = DateTime.Now;

            if (dt1.Date <= dt2.Date)
            {
                lblMora.Visible = true;
            }
            else
            {
                lblMora.Visible = false;
            }
        }
        private void buscarE()
        {
            if (textBox1.Text != "")
            {
                OdbcDataReader mostrar = controlador.funcConsultaEncabezado("renta_encabezado", textBox1.Text);
                try
                {
                    while (mostrar.Read())
                    {
                        lblFechaAlq.Text = mostrar.GetString(2);
                        lblFechaEntrega.Text = mostrar.GetString(3);
                        estado = mostrar.GetString(6);
                    }
                }
                catch (Exception err)
                {
                    Console.WriteLine(err.Message);
                }
            }
        }
        private void buscarD()
        {
            if (textBox1.Text != "")
            {
                dataGridView1.Rows.Clear();

                OdbcDataReader mostrar = controlador.funcConsultaDetalles("renta_detalle", textBox1.Text);
                try
                {
                    while (mostrar.Read())
                    {
                        dataGridView1.Rows.Add(mostrar.GetString(0), mostrar.GetString(1), mostrar.GetString(2));
                    }
                }
                catch (Exception err)
                {
                    Console.WriteLine(err.Message);
                }
            }
        }

        private void btnLimpiar_Click(object sender, EventArgs e)
        {
            dataGridView1.Rows.Clear();
            textBox1.Text = "";
            lblMora.Visible = false;
            lblEstado.Text = "";
            lblFechaAlq.Text = "";
            lblFechaEntrega.Text = "";
            btnMora.Visible = false;
            btnEntregar.Visible = true;
        }

        private void btnEntregar_Click(object sender, EventArgs e)
        {
            controlador.funcDevolver(textBox1.Text);
        }
    }
}
