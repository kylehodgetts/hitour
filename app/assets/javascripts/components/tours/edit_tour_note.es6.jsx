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
          tour: data[0]["tour"],
          notes: data[0]["tour"]["notes"]
        });
      }.bind(this)
    });
  }

  render () {
    var _this = this;
    console.log("TOUR NOTE:"+this.state.notes);
    return (
      <div>
          <div className="row">
            <div className="input-field col s12">
              <h3>Edit Note</h3>
              <textarea rows="8" cols="40"
                        id="tournotes"
                        name="tour[notes]"
                        className="materialize-textarea"
                        defaultValue={this.state.notes}/>
              <p><i>Last Modified: <span>{this.state.tour.updated_at}</span></i></p>
              <button onClick={_this.handleUpdateNote.bind(this)} >Save Changes</button>
            </div>
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
