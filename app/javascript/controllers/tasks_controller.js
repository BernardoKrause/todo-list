import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const checkboxes = document.querySelectorAll(".task-checkbox");

    checkboxes.forEach(checkbox => {
      checkbox.addEventListener("change", (event) => {
        const taskId = event.target.id.split("_")[1];  
        this.updateTaskStatus(event.target, taskId);
      });
      
      this.updateContainerStyle(checkbox.checked, checkbox.id);
    });
  }

  toggle(e) {
    const isChecked = e.target.checked;
    const idTask = e.target.id;
    this.concluidoValue = isChecked;
    this.updateContainerStyle(this.concluidoValue,idTask);
  }

  updateContainerStyle(checked, element) {
    const idNumber = element.split('_')[1];
    const taskContainer = document.querySelector(`#task_${idNumber}`);

    if (checked) {
      taskContainer.classList.add('Checked');
    } else {
      taskContainer.classList.remove('Checked');
    }
  }

  updateTaskStatus(checkbox, taskId) {
    const isChecked = checkbox.checked;
    const concluidoValue = isChecked ? 1 : 0;

    fetch(`/tasks/update_status/${taskId}`, {
      method: 'PATCH',
      headers: { 
        'Content-Type': 'application/json', 
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content') 
      },
      body: JSON.stringify({
        task: { concluido: concluidoValue }  
      })
    });
  }
}