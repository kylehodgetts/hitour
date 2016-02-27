class NewPointDatum extends React.Component {
  constructor (props) {
    super(props);
    this.state =  {
      data: [],
      pollInterval: this.props.pollInterval || 2000,
      intervalId: 0
    };
  }

  componentDidMount() {
    this.handleLoadDataFromServer();
    this.interval = setInterval(
      this.handleLoadDataFromServer.bind(this),
      this.state.pollInterval
    );
    var postUrl = this.props.new_point_datum_url;
    $('#pointDatumForm').on('submit',function(e){
      e.preventDefault();
      $.ajax({
        url: postUrl,
        type: "POST",
        data: $(this).serialize(),
        dataType: "json",
        success: function(data){
          Materialize.toast(data, 3000, 'rounded');
        }.bind(this),
        error: function(err){
          Materialize.toast('There was an issue adding the point. Please contact admin.', 3000, 'rounded');
          console.log(err);
        }.bind(this)
      });
    });
  }

  componentWillUnmount() {
    clearInterval(this.interval);
  }

  handleLoadDataFromServer() {
    //Get All Data
    $.ajax({
      url: this.props.data_url,
      type: "GET",
      dataType: "json",
      cache: false,
      success: function(data){
        this.setState({
          data: data
        });
      }.bind(this)
    });
  }

  componentDidUpdate(prevProps, prevState) {
      var check = JSON.stringify(prevState) === JSON.stringify(this.state);
      if(!check || this.state.data == []){
        $('select').material_select();
      }
  }

  render () {
    return (
      <div>
        <div>
          <span>Add Data to point</span>
          <form id="pointDatumForm" className="card-content">
            <input value={this.props.point_id} type="hidden" name="point_datum[point_id]" />
            <div className="row">
              <div className="input-field col s12">
                <select name="point_datum[datum_id]">
                  {this.state.data.map(function(datum) {
                    return (
                      <option value={datum.id} key={datum.id} >{datum.data}</option>
                    );
                  }, this)}
                </select>
                <label>Data Name</label>
              </div>
            </div>
            <button className="btn right blue waves-effect waves-light"
                    type="submit" name="action">Submit
              <i className="material-icons right">send</i>
            </button>
          </form>
        </div>
      </div>
    );
  }
}

NewPointDatum.displayName = "NewPointDatum";
NewPointDatum.propTypes = {
  new_point_datum_url:React.PropTypes.string.isRequired,
  data_url: React.PropTypes.string.isRequired,
  pollInterval: React.PropTypes.number,
  point_id: React.PropTypes.number.isRequired
}
