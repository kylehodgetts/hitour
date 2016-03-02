class TourNote extends React.Component{
  constructor (props) {
    super(props);
    this.state =  {
      updated_at: [],
      notes: ["THIS SHOULD CHANGE"],
      pollInterval: this.props.pollInterval || 2000
    };
  }

  componentDidMount () {
    this.handleLoadDataFromServer();
  }

  handleUpdateNote () {
    console.log("CLICKED ME");
    var newNote = $('#tournotes').val();
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
        console.log(data);
        this.handleLoadDataFromServer();
      }.bind(this),
      error: function(err){
        console.log(err);
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
          updated_at: data[0]["tour"]["updated_at"],
          notes: data[0]["tour"]["notes"]
        });
      }.bind(this)
    });
  }

  render () {
    var _this = this;
    return (
      <div>
          <div className="row">
            <div className="input-field col s12">
              <h3>Edit Note</h3>
              <textarea key={"noteTextArea"}
                        id="tournotes"
                        name="tour[notes]"
                        className="materialize-textarea"
                        defaultValue={this.state.notes}/>
              <p><i>Last Modified: <span>{this.state.updated_at}</span></i></p>
              <button onClick={_this.handleUpdateNote.bind(this)} >Save Changes</button>
            </div>
          </div>
      </div>
    );
  }
};

TourNote.displayName = "TourNote";
TourNote.propTypes = {
  tourUrl: React.PropTypes.string.isRequired,
  tourNotes:React.PropTypes.string.isRequired,
  updateTourPath: React.PropTypes.string.isRequired,
  pollInterval: React.PropTypes.number
}
