import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['form']

  saveNote(event){

    const noteInput = event.currentTarget

    if(noteInput.value === ''){
      Rails.ajax({
        type: 'delete',
        url: `/notes/${noteInput.dataset.noteId}`,
        data: new FormData(this.formTarget),
        success: function (data) {
          delete noteInput.dataset.noteId;
          return;
        }
      });
    }else if(event.currentTarget.hasAttribute('data-note-id')){
      Rails.ajax({
        type: 'put',
        url: `/notes/${noteInput.dataset.noteId}`,
        data: new FormData(this.formTarget),
        success: function (data) {
          data = JSON.parse(data);
        }
      });

    }else{
      Rails.ajax({
        type: 'post',
        url: '/notes',
        data: new FormData(this.formTarget),
        success: function (data) {
          data = JSON.parse(data);
          noteInput.dataset.noteId = data.id
        }
      });
    }
  }
}
