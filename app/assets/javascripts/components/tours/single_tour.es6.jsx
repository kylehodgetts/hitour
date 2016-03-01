class SingleTour extends React.Component {
  constructor (props) {
    super(props);
    this.state =  {
      tour: [],
      audience: [],
      points: [],
      tourSessions: [],
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
    // Initialise Modal
    $('.modal-trigger').leanModal();
  }

  componentWillUnmount() {
    this.interval && clearInterval(this.interval);
    this.interval = false;
  }

  handleLoadDataFromServer() {
    $.ajax({
      url: this.props.showUrl,
      type: "GET",
      dataType: "json",
      cache: false,
      success: function(data){
        this.setState({
          tour: data[0]["tour"],
          audience: data[0]["audience"],
          points: data[0]["points"],
          tourSessions: data[0]["tour_sessions"]
        });
      }.bind(this)
    });
  }

  handleDeleteDataFromServer(deleteUrl, e) {
    e.preventDefault();
    $.ajax({
      url: deleteUrl,
      type: "DELETE",
      dataType: "json",
      success: function(data){
        Materialize.toast(data, 3000, 'rounded');
        console.log("Success " + data);
      }.bind(this),
      error: function(err){
        Materialize.toast('There was an issue deleting. Please contact admin.', 3000, 'rounded');
        console.log(err);
      }.bind(this)
    });
  }

  handlePostDataToServer(rankUrl, e) {
    e.preventDefault();
    $.ajax({
      url: rankUrl,
      type: "POST",
      dataType: "json",
      success: function(data){
        Materialize.toast(data, 3000, 'rounded');
        console.log("Success " + data);
      }.bind(this),
      error: function(err){
        Materialize.toast('There was an issue updating rank. Please contact admin.', 3000, 'rounded');
        console.log(err);
      }.bind(this)
    });
  }

  render () {
    var _this = this;
    return (
      <div>
        <div>
          {this.state.tour.name &&
            <GenericEdit
                   value={this.state.tour.name}
            			 postUrl={this.props.update_tour_url}
            			 attributeName="tour[name]"
            />
          }
          {this.state.audience.name &&
            <SelectEdit
              selected={this.state.audience.name}
              options={this.props.audiences}
              postUrl={this.props.update_tour_url}
              attributeName="tour[audience_id]"
            />
          }
        </div>
        <a target="_blank" className="waves-effect waves-light blue btn left" href={this.props.pdfUrl}>
          <i className="material-icons dp48 left">receipt</i>Download PDF
        </a>
        <a className="waves-effect waves-light  blue right btn modal-trigger" href="#sessionModal">Tour Sessions</a>
        <br />
        <h4>Points</h4>
        <div className="collection">
          {this.state.points.map(function(point) {
            return (
              <div key={point.id} className="collection-item">
                <div>
                  {point.name}
                  <a id={point.id} href={point.delete_url} className="secondary-content" key={point.id}
                             onClick={_this.handleDeleteDataFromServer.bind(this, point.delete_url)}>
                  <i className=" blue-text material-icons">delete_forever</i>
                  </a>
                  <a id={point.id} href={point.show_url} className="secondary-content">
                    <i className=" blue-text material-icons">launch</i>
                  </a>
                  <a id={point.id} href="#" onClick={_this.handlePostDataToServer.bind(this, point.increase_url)}  className="secondary-content">
                    <i className=" blue-text material-icons">call_received</i>
                  </a>
                  <a id={point.id} href="#" onClick={_this.handlePostDataToServer.bind(this, point.decrease_url)} className="secondary-content">
                    <i className=" blue-text material-icons">call_made</i>
                  </a>
                </div>
              </div>
            );
          }, this)}
        </div>
        <NewTourPoint
          tour_id={this.props.tour_id}
          points_url={this.props.points_url}
          new_tour_point_url={this.props.new_tour_point_url}
          />
        <div id="sessionModal" className="modal" style={{maxHeight: '800px'}}>
          <div className="modal-content">
            <h4>Tour Sessions</h4>
            <ul className="collection" style={{
              height: '200px',
              overflow: 'hidden',
              overflowY: 'scroll'
            }}>
              {this.state.tourSessions.map(function(session) {
                return (
                  <li key={session.id} className="collection-item">
                    <span className="title"><b>{session.name}</b></span>
                    <br />
                    <span className="title"><b>Start Date:</b> {session.start_date}
                      <span><b> Duration:</b> {session.duration} days</span>
                        <p> Passphrase:
                          <a id={session.id} href={session.delete_url} className="secondary-content"
                                     onClick={_this.handleDeleteDataFromServer.bind(this, session.delete_url)}>
                          <i className=" blue-text material-icons">delete_forever</i>
                          </a>
                        </p>
                        <GenericEdit
                               value={session.passphrase}
                        			 postUrl={session.update_url}
                        			 attributeName="tour_session[passphrase]"
                               fontSize="20px"
                        />
                      </span>

                  </li>
                );
              }, this)}
            </ul>

            <NewTourSession
              tour_id={this.props.tour_id}
              new_tour_session_url={this.props.new_tour_session_url}
              />
          </div>
          <div className="modal-footer">
            <a href="#!" className=" modal-action modal-close waves-effect waves-green btn-flat">Close</a>
          </div>
        </div>
      </div>
    );
  }
}

SingleTour.displayName = "SingleTour";
SingleTour.propTypes = {
  new_tour_point_url: React.PropTypes.string.isRequired,
  showUrl: React.PropTypes.string.isRequired,
  update_tour_url: React.PropTypes.string.isRequired,
  points_url:React.PropTypes.string.isRequired,
  tour_id: React.PropTypes.number.isRequired,
  pollInterval: React.PropTypes.number,
  pdfUrl: React.PropTypes.string.isRequired,
  audiences: React.PropTypes.array,
  new_tour_session_url: React.PropTypes.string.isRequired
}
