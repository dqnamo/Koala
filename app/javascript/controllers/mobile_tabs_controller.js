import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  showTags(){
    document.getElementById('tags-col').classList.remove('hidden')
    document.getElementById('notes-col').classList.add('hidden')  
    document.getElementById('note').classList.add('hidden')
  }

  showNotes(){
    document.getElementById('tags-col').classList.add('hidden')
    document.getElementById('notes-col').classList.remove('hidden')  
    document.getElementById('note').classList.add('hidden')
  }

  showNote(){
    document.getElementById('tags-col').classList.add('hidden')
    document.getElementById('notes-col').classList.add('hidden')  
    document.getElementById('note').classList.remove('hidden')
  }
}
