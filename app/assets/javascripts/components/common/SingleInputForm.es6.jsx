class SingleInputForm extends React.Component {
  componentDidMount() {
    var postUrl = this.props.postUrl;
    var dataType = this.props.dataType;
    var id = '#' + dataType + 'Form';
    var message = 'Creating ' + dataType + '. Please wait...';
    $(id).on('submit',function(e){
      e.preventDefault();
      DataUtil.handlePostToServer(postUrl, $(this).serialize(), message, e);
      $(id).trigger("reset");
    });
  }

  render() {
    nameId = this.props.dataType + "[" + this.props.attr + "]";
    return (
      <form id={this.props.dataType + "Form"}>
        <label htmlFor={nameId}>
          {this.props.labelValue}
        </label>
        <input type="text" name={nameId} id={nameId} />
        <button className="btn right blue waves-effect waves-light"
                type="submit" name="action">Submit
          <i className="material-icons right">send</i>
        </button>
      </form>
    );
  }
}
SingleInputForm.displayName = "SingleInputForm";
SingleInputForm.propTypes = {
  postUrl: React.PropTypes.string.isRequired,
  dataType: React.PropTypes.string.isRequired,
  attr: React.PropTypes.string.isRequired,
  labelValue: React.PropTypes.string.isRequired
}
