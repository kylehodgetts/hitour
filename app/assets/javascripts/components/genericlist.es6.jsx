class GenericList extends React.Component {
  constructor (props) {
    super(props);
    this.state =  {
      data: [],
      pollInterval: this.props.pollInterval || 2000
    };
  }

  componentDidMount () {
    this.handleLoadDataFromServer();
    setInterval(this.handleLoadDataFromServer.bind(this), this.state.pollInterval);
  }

  handleLoadDataFromServer() {
    $.ajax({
      url: this.props.url,
      type: "GET",
      dataType: "json",
      cache: false,
      success: function(data){
        this.setState({ data: data });
      }.bind(this)
    });
  }

  render () {
    return (
      <div className="collection">
        {this.state.data.map(function(item) {
          return (
            <div key={item.id} className="collection-item">
              <div>
                {item.data}
                <a href="#!" className="secondary-content">
                  <i className=" blue-text material-icons">delete_forever</i>
                </a>
              </div>
            </div>
          );
        })}
      </div>
    );
  }
}

GenericList.displayName = "List";
GenericList.propTypes = {
  url: React.PropTypes.string.isRequired,
  pollInterval: React.PropTypes.number
};
