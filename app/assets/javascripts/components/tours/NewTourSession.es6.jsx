class NewTourSession extends React.Component {
  constructor (props) {
    super(props);
    this.state =  {
      points: [],
      pollInterval: this.props.pollInterval || 2000,
      intervalId: 0
    };
  }

  componentDidMount() {
    var postUrl = this.props.new_tour_session_url;
    $('#tourSessionForm').on('submit',function(e){
      e.preventDefault();
      $.ajax({
        url: postUrl,
        type: "POST",
        data: $(this).serialize(),
        dataType: "json",
        success: function(data){
          Materialize.toast(data, 3000, 'rounded');
          $('#tourSessionForm')[0].reset();
        }.bind(this),
        error: function(err){
          Materialize.toast(err, 3000, 'rounded');
          console.log(err);
        }.bind(this)
      });
    });
  }

  componentWillUnmount() {
  }

  render () {
    return (
      <div>
        <div>
          <span>Create a tour session</span>
          <form id="tourSessionForm">
            <input value={this.props.tour_id} type="hidden" name="tour_session[tour_id]" />
              <div className="row">
                <div className="input-field col s12">
                  <input id="tour_session[name]" name="tour_session[name]"
                         type="text" className="validate" />
                  <label htmlFor="tour_session[name]">Memorable Session Name</label>
                </div>
              </div>
            <div className="row">
              <div className="input-field col s6">
                <input id="tour_session[start_date]"
                       name="tour_session[start_date]" type="date"
                       className="datepicker validate"/>
              </div>
              <div className="input-field col s6">
                <input id="tour_session[duration]" name="tour_session[duration]" type="number" className="validate" />
                <label htmlFor="tour_session[duration]">Duration (Days)</label>
              </div>
            </div>
            <button title="Create Tour Session" className="btn-floating btn-large waves-effect waves-light blue right"
              type="submit" name="action">
              <i className="material-icons">add</i>
            </button>
          </form>
        </div>
      </div>
    );
  }
}

NewTourSession.displayName = "NewTourPoint";
NewTourSession.propTypes = {
  new_tour_session_url:React.PropTypes.string.isRequired,
  pollInterval: React.PropTypes.number,
  tour_id: React.PropTypes.number.isRequired
}
