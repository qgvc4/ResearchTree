import React, { Component } from 'react'

import FeedList from './FeedList'
import PostFeed from './PostFeed';

class Feed extends Component {
    render() {
        return (
            <div>
                <PostFeed />
                <FeedList />
            </div>
        )
    }
}

export default Feed;