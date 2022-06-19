import feather from "feather-icons";

window.addEventListener('turbo:load', function(){
  const renderIcons = () => feather.replace()
  window.renderIcons = renderIcons;

  renderIcons();
});