import UIKit
import CoreData

class AgregarSupervisorViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var codigoTextField: UITextField!
    @IBOutlet weak var nombreTextField: UITextField!
    @IBOutlet weak var apellidosTextField: UITextField!
    @IBOutlet weak var sueldoTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        configurarVista()
    }

    // MARK: - Configuración inicial
    private func configurarVista() {
        // Agregar cualquier configuración adicional de la vista
        self.title = "Agregar Supervisor"
        limpiarCampos()
    }

    // MARK: - Botón Guardar
    @IBAction func grabarTapped(_ sender: UIButton) {
        guard let codigoText = codigoTextField.text,
              let codigo = Int64(codigoText),
              let nombre = nombreTextField.text, !nombre.isEmpty,
              let apellidos = apellidosTextField.text, !apellidos.isEmpty,
              let sueldoText = sueldoTextField.text,
              let sueldo = Double(sueldoText) else {
            showError(message: "Por favor, complete todos los campos.")
            return
        }
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let newSupervisor = Supervisor(context: context)
        newSupervisor.codigo = codigo
        newSupervisor.nombre = nombre
        newSupervisor.apellidos = apellidos
        newSupervisor.sueldo = sueldo

        do {
            try context.save()
            navigationController?.popViewController(animated: true)
        } catch {
            showError(message: "Error al guardar los datos.")
        }
    }

    // MARK: - Mostrar error
    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    // MARK: - Utilidad para limpiar campos
    private func limpiarCampos() {
        codigoTextField.text = ""
        nombreTextField.text = ""
        apellidosTextField.text = ""
        sueldoTextField.text = ""
    }
}
