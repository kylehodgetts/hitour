class TourNote extends React.Component{
  constructor (props) {
    super(props);
    console.log(this.props.initialValue);
    this.state =  {
      tour: [],
      notes: this.props.initialValue,
      pollInterval: this.props.pollInterval || 2000
    };
  }

  componentDidMount () {
    this.handleLoadDataFromServer();
    // Initialise the editor
    editor = new Quill('#editor',{
      theme: 'snow'
    });
    editor.addModule('toolbar', {
      container: '#toolbar'     // Selector for toolbar container
    });
    editor.setHTML(this.props.initialValue);
  }

  handleUpdateNote () {
    console.log("CLICKED ME");
    var newNote = editor.getHTML();
    console.log("VALUE CHANGED to"+newNote);
    var formData = {};
    formData["tour[notes]"] = newNote;
    console.log(formData);
    var callBack = this.handleLoadDataFromServer;
    $.ajax({
      url: this.props.updateTourPath,
      type: "PATCH",
      data: formData,
      success: function(data){
        Materialize.toast(data, 3000, 'rounded');
        this.handleLoadDataFromServer();
      }.bind(this),
      error: function(err){
        Materialize.toast(err, 3000, 'rounded');
      }
    });
  }

  handleLoadDataFromServer() {
    var url = this.props.tourUrl;
    console.log("REQUESTING "+url);
    $.ajax({
      url: url,
      type: "GET",
      dataType: "json",
      cache: false,
      success: function(data){
        console.log(data);
        this.setState({
          tour: data[0]["tour"],
          notes: data[0]["tour"]["notes"]
        });
      }.bind(this)
    });
  }

  render () {
    var _this = this;
    var editorStyle = {
      height: '400',
      border: '1px solid black'
    };
    return (
      <div>
          <div className="row">
            <div className="input-field col s12">
              <h3>Edit Note</h3>
            </div>
          </div>
          <div className="row">
            <div className="quill-wrapper">
              <div id="toolbar" className="toolbar ql-snow">
                <span className="ql-format-group">
                  <select className="ql-size" defaultValue="13px">
                    <option value="10px">Small</option>
                    <option value="13px">Normal</option>
                    <option value="18px">Large</option>
                    <option value="32px">Huge</option>
                  </select>
                </span>
                <span className="ql-format-group">
                  <span className="ql-format-group">
                  	<span title="Bold" className="ql-format-button ql-bold"></span>
                  	<span className="ql-format-separator"></span>
                  	<span title="Italic" className="ql-format-button ql-italic"></span>
                  	<span className="ql-format-separator"></span>
                  	<span title="Underline" className="ql-format-button ql-underline"></span>
                  	<span className="ql-format-separator"></span>
                  	<span title="Strikethrough" className="ql-format-button ql-strike"></span>
                  </span>
                </span>
                <span className="ql-format-group">
                	<span title="List" className="ql-format-button ql-list"></span>
                	<span className="ql-format-separator"></span>
                	<span title="Bullet" className="ql-format-button ql-bullet"></span>
                	<span className="ql-format-separator"></span>
                	<span title="Text Alignment" className="ql-align ql-picker">
                	<span className="ql-picker-label" data-value="left"></span>
                	<span className="ql-picker-options">
                		<span data-value="left" className="ql-picker-item ql-selected"></span>
                		<span data-value="center" className="ql-picker-item"></span>
                		<span data-value="right" className="ql-picker-item"></span>
                		<span data-value="justify" className="ql-picker-item"></span>
                	</span>
                </span>
                  <select title="Text Alignment" className="ql-align" style={{display: 'none'}}>
                  	<option value="left" label="Left"></option>
                  	<option value="center" label="Center"></option>
                  	<option value="right" label="Right"></option>
                  	<option value="justify" label="Justify"></option>
                  </select>
                </span>
              </div>

              <div id="editor" style={editorStyle}>
              </div>
            </div>
            <p><i>Last Modified: <span>{this.state.tour.updated_at}</span></i></p>
            <a className="waves-effect waves-light btn blue right" onClick={_this.handleUpdateNote.bind(this)}>
              <i className="material-icons left">cloud</i>Save Changes
            </a>
          </div>
      </div>
    );
  }

};

TourNote.displayName = "TourNote";
TourNote.propTypes = {
  initialValue: React.PropTypes.string.isRequired,
  tourUrl: React.PropTypes.string.isRequired,
  updateTourPath: React.PropTypes.string.isRequired,
  pollInterval: React.PropTypes.number
}
