import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['form']

  saveNote(event){

    const noteInput = event.currentTarget

    const tagsRegex = /#[A-Za-z0-9]{1,}/g;
    const tags = noteInput.value.match(tagsRegex);


    if(noteInput.value === ''){
      Rails.ajax({
        type: 'delete',
        url: `/notes/${noteInput.dataset.noteId}`,
        data: new FormData(this.formTarget),
        success: function (data) {
          noteInput.dataset.noteId = '';
          return;
        }
      });
    }else if(event.currentTarget.hasAttribute('data-note-id')){
      var formData = new FormData(this.formTarget)
      if (tags !== null) formData.set('tags', tags)

      Rails.ajax({
        type: 'put',
        url: `/notes/${noteInput.dataset.noteId}`,
        data: formData,
        success: function (data) {
          data = JSON.parse(data);
        }
      });
    }else{
      var formData = new FormData(this.formTarget)
      if (tags !== null) formData.set('tags', tags)

      Rails.ajax({
        type: 'post',
        url: '/notes',
        data: formData,
        success: function (data) {
          data = JSON.parse(data);
          noteInput.dataset.noteId = data.slug
        }
      });
    }
  }
}
