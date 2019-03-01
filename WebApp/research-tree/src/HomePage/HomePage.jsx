import React from 'react';
import { Link } from 'react-router-dom';
import { connect } from 'react-redux';

import { userActions } from '../_actions';

//antd
import { Layout, Menu, Icon } from 'antd';

//c1e791 green


const {
  Header, Content, Footer, Sider,
} = Layout;

class HomePage extends React.Component {
    componentDidMount() {
        this.props.dispatch(userActions.getAll());
    }

    handleDeleteUser(id) {
        return (e) => this.props.dispatch(userActions.delete(id));
    }
    
    

    render() {
        const { user, users } = this.props;
        return (
            <Layout>
                <Sider style={{
                  overflow: 'auto', height: '100%', position: 'fixed', left: 0,
                      background: '#c1e791'
                }}
                >
                  <div className="logo" />
                    
                    <h2>ResearchTree</h2>
                    
                  <Menu theme="" mode="inline" defaultSelectedKeys={['1']} style={{ background: '#c1e791' }}>
                    <Menu.Item key="1">
                      <Icon type="user" />
                      <span className="nav-text">Feed</span>
                    </Menu.Item>
                    <Menu.Item key="2">
                      <Icon type="team" />
                      <span className="nav-text">People</span>
                    </Menu.Item>
                    <Menu.Item key="3">
                      <Icon type="shop" />
                      <span className="nav-text">Jobs</span>
                    </Menu.Item>
                    <Menu.Item key="4">
                      <Icon type="bar-chart" />
                      <span className="nav-text">Settings</span>
                    </Menu.Item>
                  
                  </Menu>
                </Sider>
                <Layout style={{  }}>
                  
                  <Content style={{ margin: '',background: '#fff', overflow: 'initial' }}>
                    <div style={{ padding: 24, background: '#fff', textAlign: 'center' }}>
                      ...
                      <br />
                      Place
                      <br />...<br />...<br />...<br />
                      Holder
                      <br />...<br />...<br />...<br />...<br />...<br />...
                      <br />...<br />...<br />...<br />...<br />...<br />...
                      <br />...<br />...<br />...<br />...<br />...<br />...
                      <br />...<br />...<br />...<br />...<br />...<br />...
                      <br />...<br />...<br />...<br />...<br />...<br />...
                      <br />...<br />...<br />...<br />...<br />...<br />...
                      <br />...<br />...<br />...<br />...<br />...<br />
                      content
                    </div>
                  </Content>
                  
                </Layout>
              </Layout>
            
        );
    }
}

function mapStateToProps(state) {
    const { users, authentication } = state;
    const { user } = authentication;
    return {
        user,
        users
    };
}

const connectedHomePage = connect(mapStateToProps)(HomePage);
export { connectedHomePage as HomePage };