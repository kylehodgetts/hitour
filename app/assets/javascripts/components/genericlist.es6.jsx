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
    e.preventDefault();
    $.ajax({
      url: deleteUrl,
      type: "DELETE",
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

  render () {
    var _this = this;
    return (
      <div className="collection">
        {this.state.data.map(function(item, i) {
          return (
            <div key={item.id} className="collection-item">
              <div>
                {item.data}
                <a id={item.id} href="" className="secondary-content" key={i}
                             onClick={_this.handleDeleteDataFromServer.bind(this, item.delete_url)}>
                  <i className=" blue-text material-icons">delete_forever</i>
                </a>
              </div>
            </div>
          );
        }, this)}
      </div>
    );
  }
}

GenericList.displayName = "List";
GenericList.propTypes = {
  getUrl: React.PropTypes.string.isRequired,
  pollInterval: React.PropTypes.number
};
