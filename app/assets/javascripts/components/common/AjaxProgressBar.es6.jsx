class AjaxProgressBar extends React.Component {
  componentDidMount() {

  }
  render () {
    var style={
      position: 'fixed',
      width: '100%',
      height: '100%',
      backgroundColor: 'hsla(224,100%,0%,0.62)',
      zIndex: '100000 !important',
      display: 'none',
      top: 0,
      left: 0
    }
    var centerProgress = {
      display: 'block',
      textAlign: 'center',
      marginTop: '20%'
    }
    var progressMessage = {
      color: 'white',
      fontSize: '20px'
    }
    return (
      <div className="progress-overlay" style={style}>
        <div className="valign-wrapper" style={centerProgress}>
          <div className="valign">
            <div className="preloader-wrapper big active">
               <div className="spinner-layer spinner-blue-only">
                 <div className="circle-clipper left">
                   <div className="circle"></div>
                 </div><div className="gap-patch">
                   <div className="circle"></div>
                 </div><div className="circle-clipper right">
                   <div className="circle"></div>
                 </div>
               </div>
             </div>
            <p style={progressMessage} className="progress-message">Please wait...</p>
          </div>
        </div>
      </div>
    );
  }
}

AjaxProgressBar.displayName = 'AjaxProgressBar';
