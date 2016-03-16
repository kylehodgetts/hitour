class SingleTour extends React.Component {
  constructor (props) {
    super(props);
    this.state =  {
      tour: [],
      audience: [],
      points: [],
      tourSessions: [],
      feedbacks: [],
      quizzes: [],
      pollInterval: this.props.pollInterval || 2000,
      intervalId: 0
    };
  }

  componentDidMount() {
    DataUtil.handleCustomLoadDataFromServer.bind(this,this.props.showUrl,function(data){
      this.setState({
        tour: data[0]["tour"],
        audience: data[0]["audience"],
        points: data[0]["points"],
        tourSessions: data[0]["tour_sessions"],
        feedbacks: data[0]["feedbacks"],
        quizzes: data[0]["quizzes"]
      });
    }.bind(this));
    this.interval = setInterval(
      DataUtil.handleCustomLoadDataFromServer.bind(this,this.props.showUrl,function(data){
        this.setState({
          tour: data[0]["tour"],
          audience: data[0]["audience"],
          points: data[0]["points"],
          tourSessions: data[0]["tour_sessions"],
          feedbacks: data[0]["feedbacks"],
          quizzes: data[0]["quizzes"]
        });
      }.bind(this)),
      this.state.pollInterval
    );
    // Initialise Modal
    $('.modal-trigger').leanModal();
  }

  componentDidUpdate(prevProps, prevState) {
    var check = JSON.stringify(prevState) === JSON.stringify(this.state);
    if(!check || this.state.tour == []){
      $('.collapsible').collapsible();
    }
  }

  componentWillUnmount() {
    this.interval && clearInterval(this.interval);
    this.interval = false;
  }

  handlePostDataToServer(rankUrl, e) {
    e.preventDefault();
    // Show Progress
    $('.progress-message').text('Updating rank. Please wait...');
    $('.progress-overlay').fadeIn(200);
    $.ajax({
      url: rankUrl,
      type: "POST",
      dataType: "json",
      success: function(data){
        $('.progress-overlay').fadeOut();
        Materialize.toast(data, 3000, 'rounded');
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
        <div className="row">
          <div className="col s12 m4 left" style={{marginBottom: '5px'}}>
            <a target="_blank" className="waves-effect waves-light blue btn" href={this.props.pdfUrl}>
              <i className="material-icons dp48 left">description</i>Download PDF</a>
          </div>
          <div className="col s12 left">
            <a className="waves-effect waves-light  blue btn modal-trigger" href="#sessionModal">
              <i className="material-icons dp48 left">view_agenda</i>Tour Sessions</a>
          </div>
        </div>
        <div className="row">
          <ul className="collapsible" data-collapsible="accordion">
            <li>
              <div className="collapsible-header"><i className="material-icons">description</i>Tour Notes - All notes written here, will be available in the PDF.</div>
              <div className="collapsible-body">
                <div className="container">
                  <TourNote
                    initialValue={this.props.tourNote}
                    tourUrl={this.props.showUrl}
                    updateTourPath={this.props.update_tour_url}
                    />
                </div>
              </div>
            </li>
          </ul>
          <ul className="collapsible" data-collapsible="accordion">
            <li>
              <div className="collapsible-header"><i className="material-icons">speaker_notes</i>Tour Feedback.</div>
              <div className="collapsible-body">
                <div className="row" style={{padding:'10px'}}>
                  {this.state.feedbacks &&
                    <Feedback
                      feedbacks={this.state.feedbacks}
                    />
                  }
                </div>
              </div>
            </li>
          </ul>
        </div>
        <h4>Points</h4>
        <div className="collection">
          {this.state.points.map(function(point) {
            if(point.name.length > 18 && $(document).width() <= 350){
              point.name = point.name.substring(0,18)+"...";
            }
            return (
              <div key={point.id} className="collection-item">
                <div>
                  <span>{point.name}</span>
                  <a id={point.id} href={point.delete_url} className="secondary-content" key={point.id}
                             onClick={DataUtil.handleDeleteDataFromServer.bind(this, point.delete_url,"Are you sure you want to delete this point from this tour?")}>
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
        <div className="row">
          <NewTourPoint
            tour_id={this.props.tour_id}
            points_url={this.props.points_url}
            new_tour_point_url={this.props.new_tour_point_url}
            />
        </div>
        <div className="row">
          {this.state.quizzes &&
            <NewTourQuiz
              tourId={this.props.tour_id}
              quizzes={this.state.quizzes}
              postUrl={this.props.postTourQuizUrl}
              />
          }
        </div>

        <div id="sessionModal" className="modal" style={{maxHeight: '800px'}}>
          <div className="modal-content">
            <h4>Tour Sessions</h4>
            <ul className="collection" style={{
              height: '140px',
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
                                     onClick={DataUtil.handleDeleteDataFromServer.bind(this, session.delete_url,"Are you sure you want to delete this session?")}>
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
            <div className="row">
                <SessionEmail
                    tourSessionsUrl={this.props.showUrl}
                />
            </div>
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
  new_tour_session_url: React.PropTypes.string.isRequired,
  tourNote: React.PropTypes.string,
  feedbackPostUrl: React.PropTypes.string.isRequired,
  postTourQuizUrl: React.PropTypes.string.isRequired
}
