using CapaModelo;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Odbc;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CapaControlador
{
    public class Controlador
    {
        Sentencias Modelo = new Sentencias();
        //clsVariableGlobal glo = new clsVariableGlobal();
        public DataTable funcObtenerCamposCombobox(string Campo1, string Campo2, string Tabla, string Estado)
        {
            string Comando = string.Format("SELECT " + Campo1 + " ," + Campo2 + " FROM " + Tabla + " WHERE " + Estado + "= 1;");
            return Modelo.funcObtenerCamposCombobox(Comando);
        }
        public OdbcDataReader funcConsultaCombo(string Campo1, string Campo2, string Tabla, string Estado, string Codigo)
        {
            string Comando = string.Format("SELECT " + Campo1 + " FROM " + Tabla + " WHERE " + Estado + "= 1 AND " + Campo2 + " = " + Codigo + ";");
            return Modelo.funcConsulta(Comando);

        }
        public OdbcDataReader funcEliminar_perfil(string Codigo)
        {
            string Consulta = "UPDATE  control_producto SET resultado_control_producto = 'Finalizado', estado_control_producto = 0 where pk_id_control_producto = " + Codigo + ";";
            return Modelo.funcModificar(Consulta);
        }
        public OdbcDataReader funcConsultaDetalles(string Tabla, string cod)
        {
            string Consulta = "SELECT * FROM " + Tabla + " Where fkidrentaencabezado = " + cod + ";";
            return Modelo.funcConsulta(Consulta);
        }
        public OdbcDataReader funcConsultaEncabezado(string Tabla, string cod)
        {
            string Consulta = "SELECT * FROM " + Tabla + " Where pkidrentaencabezado = " + cod + ";";
            return Modelo.funcConsulta(Consulta);
        }
        public OdbcDataReader funcDevolver(string Codigo)
        {
            string Consulta = "UPDATE  renta_encabezado SET Estado = 0 where pkidrentaencabezado = " + Codigo + ";";
            return Modelo.funcModificar(Consulta);
        }
    }
}
