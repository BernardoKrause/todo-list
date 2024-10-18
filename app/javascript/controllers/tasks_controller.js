import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const checkboxes = document.querySelectorAll(".task-checkbox");

    checkboxes.forEach(checkbox => {
      // Adiciona o event listener para capturar o clique na checkbox
      checkbox.addEventListener("change", (event) => {
        const taskId = event.target.dataset.taskId;  // Captura o taskId do dataset
        const listId = event.target.dataset.listId;  // Captura o listId do dataset
        this.updateTaskStatus(event.target, listId, taskId);
      });

      // Atualiza o estilo do container da tarefa ao carregar a página
      this.updateContainerStyle(checkbox.checked, checkbox.id);
    });
  }

  toggle(e) {
    const isChecked = e.target.checked;
    const idTask = e.target.id;
    this.concluidoValue = isChecked;
    this.updateContainerStyle(this.concluidoValue, idTask);
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

  // Função para atualizar o status da tarefa
  updateTaskStatus(checkbox, listId, taskId) {
    const isChecked = checkbox.checked;
    const concluidoValue = isChecked ? 1 : 0;

    // Faz a requisição para atualizar o status da tarefa
    fetch(`/lists/${listId}/tasks/update_status/${taskId}`, {
      method: 'PATCH',
      headers: { 
        'Content-Type': 'application/json', 
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content') 
      },
      body: JSON.stringify({
        task: { concluido: concluidoValue }  // Envia o valor do campo concluido
      })
    })
    .then(response => response.json())
    .then(data => {
      if (data.status === "success") {
        console.log("Status atualizado com sucesso!");
      } else {
        console.error("Erro ao atualizar status:", data.message);
      }
    })
    .catch(error => console.error('Erro na requisição:', error));
  }
}
