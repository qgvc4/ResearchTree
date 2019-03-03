import React, { Component } from 'react'
import {Redirect} from 'react-router-dom'
import {connect} from 'react-redux'

import FeedList from './FeedList'
import PostFeed from './PostFeed';

class Feed extends Component {
    render() {
        return (
            <div>
                {
                    this.props.user.token ? 
                    renderFeed(): 
                    <Redirect to='/Login' />
                }
            </div>
        )
    }
}

function renderFeed() {
    return(
        <div>
            <PostFeed />
            <FeedList />
        </div>
    );
}

const mapStateToProps = state => ({
    user: state.user.user
})

export default connect(mapStateToProps, {})(Feed);