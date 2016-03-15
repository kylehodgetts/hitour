class TourNote extends React.Component{
  constructor (props) {
    super(props);
    this.state =  {
      tour: [],
      notes: this.props.initialValue,
      pollInterval: this.props.pollInterval || 2000
    };
  }

  componentDidMount () {
    DataUtil.handleCustomLoadDataFromServer.bind(this,this.props.tourUrl,function(data){
      this.setState({
        tour: data[0]["tour"],
        notes: data[0]["tour"]["notes"]
      });
    }.bind(this));
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
    var newNote = editor.getHTML();
    var formData = {};
    formData["tour[notes]"] = newNote;
    DataUtil.handleUpdateDataToServer(this.props.updateTourPath,formData,"Updating Tour Notes...",function(){});
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
