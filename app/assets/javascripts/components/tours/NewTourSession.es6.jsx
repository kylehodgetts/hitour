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
      DataUtil.handlePostToServer(postUrl,$(this).serialize(),'Creating Tour Session. Please wait...',e);
      $('#tourSessionForm')[0].reset();
    });
  }

  render () {
    // Set Min Date to Today
    var today = new Date().toJSON().slice(0,10);
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
                <input id="tour_session[start_date]" min={today} defaultValue={today}
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

NewTourSession.displayName = 'NewTourPoint';
NewTourSession.propTypes = {
  new_tour_session_url:React.PropTypes.string.isRequired,
  pollInterval: React.PropTypes.number,
  tour_id: React.PropTypes.number.isRequired
}
