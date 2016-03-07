class GenericList extends React.Component {
  constructor (props) {
    super(props);
    this.state =  {
      data: [],
      pollInterval: this.props.pollInterval || 1000,
      intervalId: 0
    };
  }

  componentDidMount() {
    this.handleLoadDataFromServer();
    this.interval = setInterval(
      this.handleLoadDataFromServer.bind(this),
      this.state.pollInterval
    );
    this.refs['delete-confirmation'].handleTest();
  }

  componentWillUnmount() {
    clearInterval(this.interval);
  }

  handleLoadDataFromServer() {
    $.ajax({
      url: this.props.getUrl,
      type: "GET",
      cache: false,
      success: function(data){
        this.setState({
          data: data
        });
      }.bind(this)
    });
  }

  handleDeleteDataFromServer(deleteUrl, e) {
    $('#delete-confirmation').openModal();
    e.preventDefault();
    $.ajax({
      url: deleteUrl,
      type: "DELETE",
      success: function(data){
        Materialize.toast(data, 3000, 'rounded');
      }.bind(this),
      error: function(err){
        Materialize.toast('There was an issue deleting. Please contact admin.', 3000, 'rounded');
        console.log(err);
      }.bind(this)
    });
  }

  renderVerified(item) {
    if(item.activated) {
      return(
        <i title="Verified User"
           className="secondary-content green-text material-icons">
          verified_user
        </i>
      );
    }
    else {
      return(
        <i title="Unverified User"
           className="secondary-content orange-text material-icons">
          info
        </i>
      );
    }
  }
  render () {
    var _this = this;
    return (
      <div>
        <div className="collection">
          {this.state.data.map(function(item, i) {
            if(item.data.length > 25 && $(document).width() <= 350){
              item.data = item.data.substring(0,25)+"...";
            }
            return (
              <div key={item.id} className="collection-item">
                <div>
                  {item.data}
                  <a id={item.id}
                     className="secondary-content"
                      onClick={_this.handleDeleteDataFromServer.bind(this, item.delete_url)}
                     key={i}>
                    <i className=" blue-text material-icons">delete_forever</i>
                  </a>
                  {item.show_url &&
                    <a id={item.id} href={item.show_url} className="secondary-content">
                      <i className=" blue-text material-icons">launch</i>
                    </a>
                  }
                  {this.props.users &&
                    this.renderVerified(item)
                  }
                </div>
              </div>
            );
          }, this)}
        </div>
        <DeleteConfirmation ref="delete-confirmation"/>
      </div>
    );
  }
}

GenericList.displayName = "List";
GenericList.propTypes = {
  getUrl: React.PropTypes.string.isRequired,
  pollInterval: React.PropTypes.number,
  users: React.PropTypes.bool
};
